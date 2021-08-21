import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/routes/leaderboard_page/leaderboard_list.dart';
import 'package:vikings_quiz/routes/leaderboard_page/result_card.dart';
import 'package:vikings_quiz/routes/utils/error_container.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import '../bloc_mocks.dart';

void main() {
  LeaderboardBloc leaderboardBloc;
  ThemeBloc themeBloc;

  setUpAll(() {
    leaderboardBloc = MockLeaderboardBloc();
    themeBloc = MockThemeBloc();
  });

  group("Leaderboard list rendering tests", () {
    testWidgets("Testing the case where the players leaderboard is empty",
        (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());
      when(leaderboardBloc.state).thenReturn(const LeaderboardLoaded([]));

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: leaderboardBloc),
            BlocProvider.value(value: themeBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: Column(
                children: [
                  const Expanded(child: LeaderboardList()),
                ],
              ),
            ),
          )));

      // No results list
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(ResultCard), findsNothing);

      // Error message
      expect(find.byType(ErrorContainer), findsOneWidget);
      expect(find.byKey(Key("error_container_message")), findsOneWidget);
    });

    testWidgets("Testing the case where an error occurred", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());
      when(leaderboardBloc.state).thenReturn(const LeaderboardError());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: leaderboardBloc),
            BlocProvider.value(value: themeBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: Column(
                children: [
                  const Expanded(child: LeaderboardList()),
                ],
              ),
            ),
          )));

      // No results list
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(ResultCard), findsNothing);

      // Error message
      expect(find.byType(ErrorContainer), findsOneWidget);
      expect(
          find.text(
              "Could not load the leaderboards. Check your connection and try again!"),
          findsOneWidget);
    });

    testWidgets("Testing the case where the leaderboard is loading",
        (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());
      when(leaderboardBloc.state).thenReturn(const LeaderboardLoading());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: leaderboardBloc),
            BlocProvider.value(value: themeBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: Column(
                children: [
                  const Expanded(child: LeaderboardList()),
                ],
              ),
            ),
          )));

      // No results list
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(ResultCard), findsNothing);

      // Error message
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
