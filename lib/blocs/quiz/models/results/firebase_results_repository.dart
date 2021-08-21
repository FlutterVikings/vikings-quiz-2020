import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vikings_quiz/blocs/quiz/models/quiz_question.dart';
import 'package:vikings_quiz/blocs/quiz/models/quiz_result.dart';
import 'package:vikings_quiz/blocs/quiz/models/results/results_repository.dart';

/// Computes the results of the quiz having Firestore as questions data source
class FirebaseResultsRepository extends ResultsRepository<QuizQuestion> {
  /// Returns the answer to a specific question. In case the answer hasn't been
  /// set, null is returned.
  bool getAnswer(Map<int, bool> answersList, int index) {
    return answersList.containsKey(index) ? answersList[index] : null;
  }

  @override
  QuizResult calculate({
    @required List<QuizQuestion> questionsList,
    @required Map<int, bool> answersList,
    @required int timeLeft,
  }) {
    var correctAnswers = 0;

    for (var i = 0; i < questionsList.length; ++i) {
      // In case the answers map doesn't contain the index of the question, skip
      // because it means no answers have been given
      if (!answersList.containsKey(i)) {
        continue;
      }

      // Getting the answer to the question. We are sure it exists now since the
      // above step is passed
      final answer = getAnswer(answersList, i);
      if ((answer != null) && (answer)) {
        correctAnswers++;
      }
    }

    return QuizResult(
      timeLeft: timeLeft,
      correctAnswers: correctAnswers,
    );
  }

  @override
  Future<void> storeResults(QuizResult result) async {
    await FirebaseFirestore.instance.collection("tickets").add({
      "ticketId": tokenId,
      "submit_date": Timestamp.now(),
      "seconds_left": result.timeLeft,
      "correct_answers": result.correctAnswers
    });
  }
}
