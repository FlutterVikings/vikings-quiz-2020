import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:vikings_quiz/blocs/quiz/models/database/question_repository.dart';

/// Mock question repository to be used while testing the app.
class MockQuestionRepository implements QuestionRepository<int> {
  /// Determines whether [isEligible(String)] will return true or false
  final bool eligibilitySuccess;
  final List<int> _questionsList;
  MockQuestionRepository(this.eligibilitySuccess) : _questionsList = [];

  @override
  List<int> get questionsList => UnmodifiableListView(_questionsList);

  @override

  /// Fills a list containing only integer values (each of them equal to
  /// [pickedQuestions]). The length of the iterable is exactly [totalQuestions].
  Future<List<int>> getRandomQuestions(
      {@required int totalQuestions, @required int pickedQuestions}) async {
    final mockData = List.generate(totalQuestions, (index) => index);
    _questionsList
      ..clear()
      ..addAll(mockData);

    return questionsList;
  }

  @override

  /// In this mock, the id parameter is not used.
  Future<bool> isEligible(String id) async {
    return eligibilitySuccess;
  }
}
