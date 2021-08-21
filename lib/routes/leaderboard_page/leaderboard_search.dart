import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';
import 'package:vikings_quiz/routes/leaderboard_page.dart';

/// Search bar to be used inside a [LeaderboardPage] to filter the results according
/// with the given token ID (the query filter).
class LeaderboardSearch extends StatefulWidget {
  const LeaderboardSearch();

  @override
  _LeaderboardSearchState createState() => _LeaderboardSearchState();
}

class _LeaderboardSearchState extends State<LeaderboardSearch> {
  TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LayoutBuilder(
          builder: (context, sizes) {
            var searchSize = 150.0;

            if (sizes.maxWidth < 200) {
              searchSize = sizes.maxWidth * 1.3;
            }

            return SizedBox(
              width: searchSize,
              child: TextFormField(
                controller: searchController,
                cursorColor: Colors.blueAccent,
                decoration: const InputDecoration(
                  hintText: "Token ID...",
                ),
              ),
            );
          },
        ),
        IconButton(
          key: Key("leaderboard_search_button"),
          icon: const Icon(Icons.search),
          onPressed: () => context
              .read<LeaderboardBloc>()
              .add(LeaderboardEvent(filterString: searchController.text)),
        )
      ],
    );
  }
}
