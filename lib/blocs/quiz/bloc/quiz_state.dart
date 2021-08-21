import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';

/// State of the [QuizBloc] bloc
abstract class QuizState extends Equatable {
  /// Answers to questions of the quiz
  final Map<int, bool> answers;
  const QuizState({this.answers = const {}});

  @override
  List<Object> get props => [answers];
}

/// Questions for the quiz are being loaded
class QuizLoading extends QuizState {
  const QuizLoading();
}

/// Indicates that no loading is happening
class QuizReady<Q> extends QuizState {
  final List<Q> _questionsList;
  const QuizReady(this._questionsList);

  /// List of questions fetched from Firestore
  List<Q> get questionsList => UnmodifiableListView(_questionsList);

  @override
  List<Object> get props => [_questionsList];
}

/// Indicates that the quiz is over
class QuizOver extends QuizState {
  const QuizOver();
}

/// An error happened and thus the quiz cannot be run
class QuizError extends QuizState {
  /// The error message
  final String message;
  const QuizError(this.message);

  @override
  List<Object> get props => [message];
}

/// An error happened and thus the quiz cannot be run
class QuizSubmitError extends QuizState {
  /// The time the user has saved
  final int totalSecondsLeft;
  const QuizSubmitError(this.totalSecondsLeft);

  @override
  List<Object> get props => [totalSecondsLeft];
}

/// State emitted when an answer to a question has been set
class AnswerGiven extends QuizState {
  const AnswerGiven({@required Map<int, bool> answers})
      : super(answers: answers);
}
