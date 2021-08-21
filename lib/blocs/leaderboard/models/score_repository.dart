import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Represents the score of a player
class Score extends Equatable {
  /// The time left to the end of the quiz
  final Duration timeLeft;

  /// The ID of the ticked
  final String tickedId;

  /// The position in the ranking
  final int position;

  /// The number of correct answers
  final int correctAnswers;

  const Score({
    @required this.timeLeft,
    @required this.tickedId,
    @required this.position,
    @required this.correctAnswers,
  });

  /// Builds a new [Score] instance from a Firestore [QueryDocumentSnapshot]
  /// instance. The [rank] parameter indicates the player's placement on the game
  /// leaderboard.
  Score.fromFirestore(QueryDocumentSnapshot documentSnapshot, int rank)
      : timeLeft =
            Duration(seconds: documentSnapshot.get("seconds_left") as int),
        tickedId = documentSnapshot.get("ticketId") as String,
        position = rank,
        correctAnswers = documentSnapshot.get("correct_answers") as int;

  @override
  List<Object> get props => [timeLeft, tickedId, position, correctAnswers];
}
