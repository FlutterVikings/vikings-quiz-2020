import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vikings_quiz/blocs/quiz/models/database/question_repository.dart';
import 'package:vikings_quiz/blocs/quiz/models/quiz_question.dart';
import 'package:vikings_quiz/configurations.dart';

/// Fetches a series of questions from the Cloud Firestore database
class FirebaseQuestionRepository implements QuestionRepository<QuizQuestion> {
  final List<QuizQuestion> _questionsList;
  final Duration httpTimeout;
  FirebaseQuestionRepository(
      {this.httpTimeout = ConfigurationValues.httpTimeout})
      : _questionsList = [];

  @override
  List<QuizQuestion> get questionsList => UnmodifiableListView(_questionsList);

  @override

  /// Randomly picks [pickedQuestions] documents from Firestore and returns them
  /// inside a model class ([QuestionRepository]). Note that:
  ///
  ///   - [totalQuestions] is the total amount of questions to read from
  ///   Firestore. Of these, only [pickedQuestions] will be returned.
  ///
  ///   - [pickedQuestions] is the number of documents (questions) to be picked and
  ///   thus asked in the quiz
  Future<List<QuizQuestion>> getRandomQuestions({
    @required int totalQuestions,
    @required int pickedQuestions,
  }) async {
    try {
      // Getting all random questions IDs and then shuffling the array
      final idsList = List.generate(totalQuestions, (index) => index)
        ..shuffle();

      // Getting the first N questions to be asked. The +1 in the end is there
      // because the 'end' parameter of the list is EXCLUSIVE.
      final questionsIds = idsList.sublist(0, pickedQuestions + 1);
      final documents = await FirebaseFirestore.instance
          .collection("questions")
          .where("id", whereIn: questionsIds)
          .get()
          .timeout(httpTimeout);

      // Storing questions in an internal array
      final questions = documents.docs
          .map((queryDocSnapshot) => QuizQuestion(queryDocSnapshot))
          .toList();

      _questionsList
        ..clear()
        ..addAll(questions);

      return questionsList;
    } on Exception catch (_) {
      return const [];
    }
  }

  @override

  /// This function checks whether the user has already submitted his score or
  /// not. The [id] variable expects a Tito ticket ID.
  Future<bool> isEligible(String id) async {
    try {
      final document = await FirebaseFirestore.instance
          .collection("tickets")
          .where("ticketId", isEqualTo: id)
          .get()
          .timeout(httpTimeout);

      // A person can play only once and not more. If the list is empty, it means
      // that no ticket like this have been submitted and thus the user hasn't
      // played the quiz yet.
      return document.docs.isEmpty;
    } on Exception catch (_) {
      return false;
    }
  }
}
