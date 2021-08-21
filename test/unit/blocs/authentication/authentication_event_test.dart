import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/authentication/authentication.dart';

void main() {
  group("AuthenticationEvent tests to make sure that value comparison works",
      () {
    test("Making sure Equatable has been properly overridden", () {
      expect(const AppStarted(), const AppStarted());
      expect(const ValidationSucceeded(), const ValidationSucceeded());
    });
  });
}
