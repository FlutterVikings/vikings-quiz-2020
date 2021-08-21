import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';
import 'package:vikings_quiz/routes/leaderboard_page/result_card.dart';
import 'package:vikings_quiz/routes/utils/error_container.dart';
import 'package:vikings_quiz/routes/utils/shadow_container.dart';

/// A list containing the players' scores
class LeaderboardList extends StatelessWidget {
  const LeaderboardList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardLoaded) {
          // Notify the user in case there were no data to display. This is also
          // good in case the user typed a wrong ticket ID
          if (state.gameScores.isEmpty) {
            return const _NoItems();
          }

          // Responsive list
          return LayoutBuilder(
            builder: (context, sizes) {
              var listWidth = 350.0;

              if (sizes.maxWidth < 400) {
                listWidth = sizes.maxWidth / 1.3;
              }

              return SizedBox(
                width: listWidth,
                child: ListView.builder(
                  itemCount: state.gameScores.length,
                  itemBuilder: (context, index) {
                    final data = state.gameScores[index];

                    return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ResultCard(
                          position: data.position,
                          score: data.correctAnswers,
                          timeLeft: data.timeLeft,
                          tickedId: data.tickedId,
                        ));
                  },
                ),
              );
            },
          );
        }

        if (state is LeaderboardError) {
          return Center(
            child: ShadowContainer(
              child: ErrorContainer(
                errorMessage: "Could not load the leaderboards. "
                    "Check your connection and try again!",
                buttonCallback: () => Navigator.of(context).pop(),
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

/// A [ShadowContainer] placed at the center of the screen that shows an error
/// message saying that the repository returned an empty list.
class _NoItems extends StatelessWidget {
  const _NoItems();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShadowContainer(
        child: ErrorContainer(
          errorMessage:
              "No entries found! Either there are no data for your search or "
              " there is a connection problem!",
          buttonCallback: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
