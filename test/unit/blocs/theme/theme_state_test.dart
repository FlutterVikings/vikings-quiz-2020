import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/theme/theme.dart';

void main() {
  group("ThemeState tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(DarkTheme(), DarkTheme());
      expect(LightTheme(), LightTheme());
    });
  });
}
