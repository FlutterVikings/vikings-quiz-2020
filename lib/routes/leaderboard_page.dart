import 'package:flutter/material.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';
import 'package:vikings_quiz/routes/leaderboard_page/leaderboard_list.dart';
import 'package:vikings_quiz/routes/leaderboard_page/leaderboard_search.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import 'package:vikings_quiz/routes/utils/vertical_separator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shows the scores of the players along with a search bar to look for specific
/// results
class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage();

  @override
  Widget build(BuildContext context) {
    return VikingScaffold(
      title: "Leaderboards",
      leadingIcon: false,
      body: Column(
        children: const [
          // The search bar
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: LeaderboardSearch(),
          ),

          // Gap between the search bar and the list
          VerticalSeparator(
            size: 30,
          ),

          // List with players' scores
          Expanded(child: LeaderboardList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.update),
        onPressed: () => context
            .read<LeaderboardBloc>()
            .add(LeaderboardEvent(clearCache: true)),
      ),
    );
  }
}
