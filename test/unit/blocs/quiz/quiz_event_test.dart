import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';

void main() {
  group("QuizEvent tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(
        const QuizStarted(
            tokenId: "abc",
            totalGameDuration: 3600,
            toBePicked: 15,
            totalQuestions: 200),
        const QuizStarted(
            tokenId: "abc",
            totalGameDuration: 3600,
            toBePicked: 15,
            totalQuestions: 200),
      );

      expect(
        const QuizStarted(
            tokenId: "abc",
            totalGameDuration: 3600,
            toBePicked: 15,
            totalQuestions: 200),
        isNot(const QuizStarted(
            tokenId: "_",
            totalGameDuration: 3600,
            toBePicked: 15,
            totalQuestions: 200)),
      );

      expect(const QuizFinished(timeLeft: 3600),
          const QuizFinished(timeLeft: 3600));

      expect(const QuizFinished(timeLeft: 3600),
          isNot(const QuizFinished(timeLeft: 3)));

      expect(const NewAnswer(answer: true, questionIndex: 1),
          const NewAnswer(answer: true, questionIndex: 1));

      expect(const NewAnswer(answer: true, questionIndex: 1),
          isNot(const NewAnswer(answer: false, questionIndex: 1)));
    });
  });
}
