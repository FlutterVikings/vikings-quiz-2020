import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/validation/validation.dart';

void main() {
  group("ValidationState tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(const ValidationNone(), const ValidationNone());
      expect(const ValidationLoading(), const ValidationLoading());
      expect(const ValidationFailed("test"), const ValidationFailed("test"));
      expect(const ValidationFailed("test"), isNot(const ValidationFailed("")));
    });
  });
}
