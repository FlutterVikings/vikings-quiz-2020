import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// A question to be asked in the quiz. It contains the text, the correct answer
/// and a piece of code (if any).
class QuizQuestion {
  /// The body of the question
  final String question;

  /// The value of the correct answer
  final bool correctAnswer;

  /// The piece of code attached to the question
  final String code;
  const QuizQuestion.fromData(
      {@required this.question, @required this.correctAnswer, this.code = ""});

  QuizQuestion(QueryDocumentSnapshot doc)
      : question = doc.get("question") as String,
        correctAnswer = doc.get("answer") as bool,
        code = doc.data().containsKey("code") ? doc.get("code") as String : "";

  /// Tells whether the question has a code snipped associated or not
  bool get hasCode => code.length > 0;
}
