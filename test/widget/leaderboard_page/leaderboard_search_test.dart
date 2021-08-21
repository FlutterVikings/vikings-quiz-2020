import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/routes/leaderboard_page/leaderboard_search.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import '../bloc_mocks.dart';

void main() {
  LeaderboardBloc leaderboardBloc;
  ThemeBloc themeBloc;

  setUpAll(() {
    leaderboardBloc = MockLeaderboardBloc();
    themeBloc = MockThemeBloc();
  });

  group("LeaderboardSearch rendering tests", () {
    testWidgets("Testing the rendering of the text field and the button",
        (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: leaderboardBloc),
            BlocProvider.value(value: themeBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: LeaderboardSearch(),
            ),
          )));

      // A TextFormField and an icon button
      expect(find.byKey(Key("leaderboard_search_button")), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);

      // Ensuring a responsive layout
      expect(find.byType(LayoutBuilder), findsOneWidget);
    });

    testWidgets("Testing the empty text filter", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: leaderboardBloc),
            BlocProvider.value(value: themeBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: LeaderboardSearch(),
            ),
          )));

      await tester.tap(find.byKey(Key("leaderboard_search_button")));
      verify(leaderboardBloc.add(LeaderboardEvent(filterString: ""))).called(1);
    });

    testWidgets("Testing the text filter", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: leaderboardBloc),
            BlocProvider.value(value: themeBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: LeaderboardSearch(),
            ),
          )));

      await tester.enterText(find.byType(TextFormField), "abc");
      await tester.tap(find.byKey(Key("leaderboard_search_button")));

      verify(leaderboardBloc.add(LeaderboardEvent(filterString: "abc")))
          .called(1);
    });
  });
}
