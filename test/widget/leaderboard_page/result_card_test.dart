import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/routes/leaderboard_page/card_entry.dart';
import 'package:vikings_quiz/routes/leaderboard_page/result_card.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import '../bloc_mocks.dart';

void main() {
  ThemeBloc themeBloc;

  setUpAll(() {
    themeBloc = MockThemeBloc();
  });

  group("ResultCard rendering tests", () {
    testWidgets("Testing the rendering of the card contents", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());

      await tester.pumpWidget(BlocProvider.value(
          value: themeBloc,
          child: MaterialApp(
            home: VikingScaffold(
              body: ResultCard(
                position: 1,
                timeLeft: Duration(seconds: 10),
                score: 15,
                tickedId: "123",
              ),
            ),
          )));

      // A TextFormField and an icon button
      expect(find.text("123"), findsOneWidget);
      expect(find.text("15"), findsOneWidget);
      expect(find.text("1"), findsOneWidget);
      expect(find.byType(CardEntry), findsNWidgets(4));
    });
  });
}
