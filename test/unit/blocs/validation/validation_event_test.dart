import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/validation/validation.dart';

void main() {
  group("ValidationEvent tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(const ValidationEvent(token: "test"),
          const ValidationEvent(token: "test"));
      expect(const ValidationEvent(token: "test"),
          isNot(const ValidationEvent(token: "")));
    });
  });
}
