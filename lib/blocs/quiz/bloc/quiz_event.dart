import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';

/// Events for the [QuizBloc] bloc
abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

/// Event fired when the quiz is started
class QuizStarted extends QuizEvent {
  /// The ID of the player of the quiz
  final String tokenId;

  /// Total number of questions in the database
  final int totalQuestions;

  /// Number of questions to ask to the user
  final int toBePicked;

  /// The total duration of the game
  final int totalGameDuration;

  const QuizStarted({
    @required this.tokenId,
    @required this.totalQuestions,
    @required this.toBePicked,
    @required this.totalGameDuration,
  });

  @override
  List<Object> get props =>
      [tokenId, totalQuestions, toBePicked, totalGameDuration];
}

/// Event fired when the quiz is finished
class QuizFinished extends QuizEvent {
  /// The remaining time
  final int timeLeft;

  const QuizFinished({
    @required this.timeLeft,
  });

  @override
  List<Object> get props => [timeLeft];
}

/// Event fired when the user answered to a question
class NewAnswer extends QuizEvent {
  /// The index of the question
  final int questionIndex;

  /// The given answer
  final bool answer;
  const NewAnswer({@required this.questionIndex, @required this.answer});

  @override
  List<Object> get props => [questionIndex, answer];
}
