import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';

void main() {
  group("QuizState tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(const QuizLoading(), const QuizLoading());
      expect(const QuizOver(), const QuizOver());
      expect(
          const QuizReady<String>(["abc"]), const QuizReady<String>(["abc"]));
      expect(const QuizError("abc"), const QuizError("abc"));
      expect(const QuizSubmitError(1), const QuizSubmitError(1));

      expect(
        const AnswerGiven(answers: {}),
        const AnswerGiven(answers: {}),
      );

      expect(
        const AnswerGiven(answers: {1: true}),
        isNot(const AnswerGiven(answers: {})),
      );
    });
  });
}
