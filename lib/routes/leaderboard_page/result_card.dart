import 'package:flutter/material.dart';
import 'package:vikings_quiz/routes/leaderboard_page/card_entry.dart';
import 'package:vikings_quiz/routes/leaderboard_page/leaderboard_list.dart';

/// Shows the scores of a player in the [LeaderboardList] widget
class ResultCard extends StatelessWidget {
  /// The player's position in the leaderboard
  final int position;

  /// The time left of the game the player played
  final Duration timeLeft;

  /// The amount of correct answers
  final int score;

  /// The ticket ID of the user
  final String tickedId;
  const ResultCard({
    @required this.position,
    @required this.timeLeft,
    @required this.score,
    @required this.tickedId,
  });

  String computeTime(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (minutes > 0) {
      return "$minutes min. $seconds sec.";
    } else {
      if (seconds > 0) {
        return "$seconds sec.";
      } else {
        return "No time left.";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeStr = computeTime(timeLeft);

    return Card(
      child: ListTile(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CardEntry(
              title: "Position",
              value: "$position",
            ),
            CardEntry(
              title: "Score",
              value: "$score",
            ),
            CardEntry(
              title: "Time left",
              value: timeStr,
            ),
            CardEntry(
              title: "Ticket",
              value: tickedId,
            ),
          ],
        ),
        trailing: Text("$position",
          style: TextStyle(
            fontSize: 23,
            fontFamily: 'GrenzeGotisch',
          ),
        )
      ),
      elevation: 5,
    );
  }
}
