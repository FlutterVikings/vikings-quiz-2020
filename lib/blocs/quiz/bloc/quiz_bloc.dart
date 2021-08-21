import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/countdown/countdown.dart';
import 'package:vikings_quiz/blocs/quiz/models/results/results_repository.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';

/// Bloc that handles the quiz game. Loads questions, exposes them and calculates
/// the results to be submitted.
///
/// The generic parameter `Q` represents the type of the returned data fetched
/// from a repository (which can be Firestore, a local database, a JSON file...)
class QuizBloc<Q> extends Bloc<QuizEvent, QuizState> {
  /// Repository for the questions
  final QuestionRepository<Q> questionRepository;

  /// Repository used to compute the results
  final ResultsRepository<Q> resultsRepository;

  /// Reference requried in order to tell the [CountdownBloc] to start the timer
  /// which will end the quiz if the counter arrived at zero.
  final CountdownBloc countdownBloc;

  QuizBloc({
    @required this.questionRepository,
    @required this.resultsRepository,
    @required this.countdownBloc,
  }) : super(const QuizLoading());

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is QuizStarted) {
      yield* _mapEventToQuizStarted(event);
    }

    if (event is QuizFinished) {
      yield* _mapEventToQuizFinished(event);
    }

    if (event is NewAnswer) {
      yield* _mapEventToNewAnswer(event);
    }
  }

  Stream<QuizState> _mapEventToQuizStarted(QuizStarted event) async* {
    yield const QuizLoading();

    // Store the token so that it can be referenced later
    resultsRepository.tokenId = event.tokenId;

    // Checks whether the user has already played the quiz or not
    final canPlay = await questionRepository.isEligible(event.tokenId);

    if (canPlay) {
      try {
        // Loads questions from the repository. There must be at least 1
        final questions = await questionRepository.getRandomQuestions(
            totalQuestions: event.totalQuestions,
            pickedQuestions: event.toBePicked);

        // If there are no questions, it means that something gone wrong while
        // the repository tried to fetch the data
        if (questions.isEmpty) {
          yield const QuizError("Please check your internet connection!");
        } else {
          // All good up to here, questions have been retrieved and thus the game
          // can start!
          yield QuizReady<Q>(questions);

          // Initialize the counter for the quiz
          countdownBloc
              .add(CountdownStarted(duration: event.totalGameDuration));
        }
      } on Exception {
        yield const QuizError("There's been an error while fetching the "
            "questions. Please try again or contact the support team!");
      }
    } else {
      yield const QuizError("You can't play the quiz more than once!");
    }
  }

  Stream<QuizState> _mapEventToQuizFinished(QuizFinished event) async* {
    yield const QuizLoading();

    // Computing the results
    final results = resultsRepository.calculate(
      questionsList: questionRepository.questionsList,
      answersList: state.answers,
      timeLeft: event.timeLeft,
    );

    // Store the results using the repository
    try {
      await resultsRepository.storeResults(results);
      yield const QuizOver();
    } on Exception {
      // In case something went wrong, the user can press a "retry" button to
      // submit the results again
      yield QuizSubmitError(event.timeLeft);
    }
  }

  Stream<QuizState> _mapEventToNewAnswer(NewAnswer event) async* {
    // Data of the answer
    final index = event.questionIndex;
    final answer = event.answer;

    // Updating the state
    final data = Map<int, bool>.from(state.answers);
    data[index] = answer;

    // Update the UI
    yield AnswerGiven(answers: data);
  }
}
