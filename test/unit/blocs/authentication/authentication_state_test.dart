import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/authentication/authentication.dart';

void main() {
  group("AuthenticationState tests to make sure that value comparison works",
      () {
    test("Making sure Equatable has been properly overridden", () {
      expect(
          const AuthenticationDoneLoading(), const AuthenticationDoneLoading());
      expect(const AuthenticationSucceeded(), const AuthenticationSucceeded());
      expect(const AuthenticationLoading(), const AuthenticationLoading());
      expect(const AuthenticationNoQuiz(), const AuthenticationNoQuiz());
    });
  });
}
