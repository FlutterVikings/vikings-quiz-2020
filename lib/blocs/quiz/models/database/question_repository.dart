import 'package:flutter/material.dart';

/// Abstract repository to be *implemented* that defines how the list of questions
/// for the quiz has to be retrieved from a data source (whether it be an online
/// service or a local resource).
abstract class QuestionRepository<T> {
  /// Returns a list containing the questions to be asked. The list will contain
  /// values after [getRandomQuestions(int, int)] is called
  List<T> get questionsList;

  /// Randomly chooses [pickedQuestions] items out of [totalQuestions]
  Future<List<T>> getRandomQuestions(
      {@required int totalQuestions, @required int pickedQuestions});

  /// This function checks whether the user has already submitted his score or
  /// not. The [id] variable is used to uniquely identify a player.
  Future<bool> isEligible(String id);
}
