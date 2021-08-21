import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

/// Model class used to store the results of the quiz
class QuizResult extends Equatable {
  /// The remaining time
  final int timeLeft;

  /// The total amount of correct answers
  final int correctAnswers;

  const QuizResult({
    @required this.timeLeft,
    @required this.correctAnswers,
  });

  @override
  List<Object> get props => [timeLeft, correctAnswers];
}
