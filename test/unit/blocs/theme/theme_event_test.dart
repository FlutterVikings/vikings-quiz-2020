import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/theme/theme.dart';

void main() {
  group("ThemeEvent tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(const DarkEvent(), const DarkEvent());
      expect(const LightEvent(), const LightEvent());
    });
  });
}
