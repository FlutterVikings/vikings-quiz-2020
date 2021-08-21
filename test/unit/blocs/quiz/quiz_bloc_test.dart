import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/countdown/countdown.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';

class MockCountdownBloc extends MockBloc<CountdownBloc>
    implements CountdownBloc {}

void main() {
  QuizBloc<int> eligibleQuizBloc;
  QuizBloc<int> notEligibleQuizBloc;
  CountdownBloc countdownBloc;
  int totalMockQuestions;
  int mockQuestionsToAsk;
  int totalGameDuration;

  setUp(() {
    countdownBloc = MockCountdownBloc();

    eligibleQuizBloc = QuizBloc(
        resultsRepository: MockResultsRepository(),
        questionRepository: MockQuestionRepository(true),
        countdownBloc: countdownBloc);

    notEligibleQuizBloc = QuizBloc(
        resultsRepository: MockResultsRepository(),
        questionRepository: MockQuestionRepository(false),
        countdownBloc: countdownBloc);

    totalMockQuestions = 3;
    mockQuestionsToAsk = 2;
    totalGameDuration = 10800;
  });

  group("QuizBloc with fails", () {
    test("The initial state must be 'QuizLoading'", () {
      expect(notEligibleQuizBloc.state, const QuizLoading());
      expect(eligibleQuizBloc.state.answers.length, 0);
    });

    blocTest<QuizBloc<int>, QuizState>(
        "Fail in case the user already played the quiz once",
        build: () => notEligibleQuizBloc,
        act: (bloc) => bloc.add(QuizStarted(
            tokenId: "ABCD-E",
            totalQuestions: totalMockQuestions,
            toBePicked: mockQuestionsToAsk,
            totalGameDuration: totalGameDuration)),
        expect: const [
          QuizLoading(),
          QuizError("You can't play the quiz more than once!")
        ]);
  });

  group("QuizBloc with success", () {
    test("The initial state must be 'QuizLoading'", () {
      expect(eligibleQuizBloc.state, const QuizLoading());
      expect(eligibleQuizBloc.state.answers.length, 0);
    });

    blocTest<QuizBloc<int>, QuizState>(
      "Success in case the token ID is correct and the user hasn't already played",
      build: () => eligibleQuizBloc,
      act: (bloc) => bloc.add(QuizStarted(
          tokenId: "ABCD-E",
          totalQuestions: totalMockQuestions,
          toBePicked: mockQuestionsToAsk,
          totalGameDuration: totalGameDuration)),
      expect: [
        const QuizLoading(),
        QuizReady<int>([0, 1, 2])
      ],
      verify: (bloc) => expect(bloc.state.answers.length, 0),
    );

    blocTest<QuizBloc<int>, QuizState>("Quiz results successfully stored",
        build: () => eligibleQuizBloc,
        act: (bloc) => bloc.add(QuizFinished(timeLeft: 0)),
        expect: const [
          QuizLoading(),
          QuizOver(),
        ]);

    blocTest<QuizBloc<int>, QuizState>("Quiz results stored with an error",
        build: () => QuizBloc(
            resultsRepository: MockResultsRepository(storeSuccess: false),
            questionRepository: MockQuestionRepository(true),
            countdownBloc: countdownBloc),
        act: (bloc) => bloc.add(QuizFinished(timeLeft: 0)),
        expect: const [
          QuizLoading(),
          QuizSubmitError(0),
        ]);

    blocTest<QuizBloc<int>, QuizState>("Given answer test",
        build: () => eligibleQuizBloc,
        act: (bloc) => bloc.add(NewAnswer(questionIndex: 1, answer: true)),
        expect: const [
          AnswerGiven(answers: {1: true})
        ]);
  });
}
