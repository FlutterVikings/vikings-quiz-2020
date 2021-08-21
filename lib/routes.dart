import 'package:flutter/material.dart';
import 'package:vikings_quiz/routes/info_page.dart';
import 'package:vikings_quiz/routes/leaderboard_page.dart';
import 'package:vikings_quiz/routes/quiz_page.dart';

import 'routes/home_page.dart';

/// Route management class that handles the navigation among various pages of the
/// app. New routes should be opened in the following ways:
///
/// ```dart
/// Navigator.of(context).pushNamed(RouteGenerator.homePage);
/// Navigator.pushNamed(context, RouteGenerator.homePage);
/// ```
///
/// No differences since both ways are valid.
class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute<HomePage>(
          builder: (_) => const HomePage(),
        );

      case quizPage:
        return MaterialPageRoute<QuizPage>(
          builder: (_) => const QuizPage(),
        );

      case leaderboardPage:
        return MaterialPageRoute<LeaderboardPage>(
          builder: (_) => const LeaderboardPage(),
        );

      case infoPage:
        return MaterialPageRoute<InfoPage>(
          builder: (_) => const InfoPage(),
        );

      default:
        throw const RouteException("Route not found");
    }
  }

  // Hard-coded route names
  static const homePage = "/";
  static const quizPage = "/quiz";
  static const leaderboardPage = "/leaderboard";
  static const infoPage = "/info";
}

/// Exception to be thrown when the route being pushed doesn't exist
class RouteException implements Exception {
  /// The error message
  final String message;
  const RouteException(this.message);
}
