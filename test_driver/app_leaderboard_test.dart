import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Leaderboards page test", () {
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

    test("The search bar must appear at the top", () async {
      final leaderboardButton =
          find.byValueKey("viking_scaffold_leaderboard_button");
      await driver.tap(leaderboardButton);

      final textEmpty = await driver.getText(find.byType("TextFormField"));
      expect(textEmpty, "");

      final loadingSpinner = find.byType("CircularProgressIndicator");
      await driver.waitForAbsent(loadingSpinner);
    });
  });
}
