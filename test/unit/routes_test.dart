import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';
import 'package:vikings_quiz/routes.dart';

void main() {
  group("Making sure that route names are consistent", () {
    test("Verifying route names", () {
      expect(RouteGenerator.homePage, "/");
      expect(RouteGenerator.quizPage, "/quiz");
      expect(RouteGenerator.leaderboardPage, "/leaderboard");
      expect(RouteGenerator.infoPage, "/info");
    });

    test("Checking routes health", () {
      // Determines the status of the test
      var success = true;

      // The list of routes to be tested
      final routes = <String>[
        RouteGenerator.homePage,
        RouteGenerator.quizPage,
        RouteGenerator.leaderboardPage,
        RouteGenerator.infoPage,
      ];

      try {
        // Making sure no exceptions are thrown inside routes
        for (var route in routes) {
          final setting = RouteSettings(name: route);

          RouteGenerator.generateRoute(setting);
        }
      } on Exception {
        success = false;
      }

      expect(success, true);
    });

    test("Checking the type of the exception thrown", () {
      expect(() {
        RouteGenerator.generateRoute(RouteSettings(name: ""));
      }, throwsA(isA<RouteException>()));
    });
  });
}
