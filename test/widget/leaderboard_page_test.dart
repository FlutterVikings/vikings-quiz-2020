import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vikings_quiz/blocs/leaderboard/bloc/leaderboard_bloc.dart';
import 'package:vikings_quiz/routes/leaderboard_page.dart';
import 'package:vikings_quiz/routes/leaderboard_page/leaderboard_list.dart';
import 'package:vikings_quiz/routes/leaderboard_page/leaderboard_search.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';

import 'bloc_mocks.dart';

void main() {
  ThemeBloc themeBloc;
  LeaderboardBloc leaderboardBloc;

  setUpAll(() {
    themeBloc = MockThemeBloc();
    leaderboardBloc = MockLeaderboardBloc();
  });

  group("Leaderboard page rendering tests", () {
    testWidgets("Making sure the page is rendered with essential widgets",
        (tester) async {
      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: leaderboardBloc),
          ],
          child: const MaterialApp(
            home: LeaderboardPage(),
          )));

      expect(find.byType(VikingScaffold), findsOneWidget);
      expect(find.byType(LeaderboardSearch), findsOneWidget);
      expect(find.byType(LeaderboardList), findsOneWidget);
    });
  });
}
