import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Vikings app home page test", () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();

      // Needed to wait for the HydratedStorage to load
      await Future.delayed(const Duration(seconds: 2));
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test("The token input field must be empty on first startup", () async {
      expect(await driver.getText(find.byType("TextFormField")), "");
    });

    test("Making sure the input field is writeable", () async {
      final textEmpty = await driver.getText(find.byType("TextFormField"));
      expect(textEmpty, "");

      await driver.tap(find.byType("TextFormField"));
      await driver.enterText("abc-def");

      final textFilled = await driver.getText(find.byType("TextFormField"));
      expect(textFilled, "abc-def");
    });

    test("Making sure the buttons to open the info page actually work",
        () async {
      final infoButton = find.byValueKey("validation_form_info");
      final appBarTitle = find.byValueKey("viking_appbar_title");

      await driver.tap(infoButton);
      expect(await driver.getText(appBarTitle), "Quiz info");
    });
  });
}
