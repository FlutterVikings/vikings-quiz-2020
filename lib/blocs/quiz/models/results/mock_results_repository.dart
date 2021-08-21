import 'package:flutter/cupertino.dart';
import 'package:vikings_quiz/blocs/quiz/models/quiz_result.dart';
import 'package:vikings_quiz/blocs/quiz/models/results/results_repository.dart';

/// Computes fake quiz results. This class is meant to be used as mock while
/// writing tests.
class MockResultsRepository extends ResultsRepository<int> {
  /// Tells whether the [storeResults] method will throw an [Exception] or not
  final bool storeSuccess;
  MockResultsRepository({this.storeSuccess = true});

  @override
  QuizResult calculate({
    @required List<int> questionsList,
    @required Map<int, bool> answersList,
    @required int timeLeft,
  }) {
    return QuizResult(timeLeft: timeLeft, correctAnswers: questionsList.length);
  }

  @override
  Future<void> storeResults(QuizResult result) async {
    if (storeSuccess) {
      await Future.delayed(const Duration(seconds: 2));
    } else {
      throw Exception("Call failed.");
    }
  }
}
