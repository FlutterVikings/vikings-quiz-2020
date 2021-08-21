import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';

void main() {
  group("QuizResult tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(
          const QuizResult(
            timeLeft: 3,
            correctAnswers: 10,
          ),
          const QuizResult(
            timeLeft: 3,
            correctAnswers: 10,
          ));

      expect(
          const QuizResult(
            timeLeft: 1,
            correctAnswers: 10,
          ),
          isNot(const QuizResult(
            timeLeft: 3,
            correctAnswers: 10,
          )));
    });
  });
}
