import 'package:flutter/material.dart';
import 'package:vikings_quiz/blocs/quiz/models/quiz_result.dart';

/// Computes the results of the quiz game
abstract class ResultsRepository<Q> {
  ResultsRepository();

  /// The token ID of the user, submitted in the "login form"
  var tokenId = "";

  /// Computes the results of the quiz in a [QuizResult] object.
  QuizResult calculate({
    @required List<Q> questionsList,
    @required Map<int, bool> answersList,
    @required int timeLeft,
  });

  /// Stores the results on the database
  Future<void> storeResults(QuizResult result);
}
