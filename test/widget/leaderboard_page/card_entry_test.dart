import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vikings_quiz/routes/leaderboard_page/card_entry.dart';
import 'package:vikings_quiz/routes/utils/horizontal_separator.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import '../bloc_mocks.dart';

void main() {
  ThemeBloc themeBloc;

  setUpAll(() {
    themeBloc = MockThemeBloc();
  });

  group("CardEntry rendering tests", () {
    testWidgets("Making sure widgets are properly rendered", (tester) async {
      await tester.pumpWidget(BlocProvider.value(
        value: themeBloc,
        child: MaterialApp(
          home: VikingScaffold(
            body: CardEntry(
              title: "Title",
              value: "Value",
            ),
          ),
        ),
      ));

      expect(find.text("Title:"), findsOneWidget);
      expect(find.text("Value"), findsOneWidget);

      // Making sure entries are separated with a certain gap
      expect(find.byType(HorizontalSeparator), findsOneWidget);
    });
  });
}
