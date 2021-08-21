import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vikings_quiz/routes/info_page.dart';
import 'package:vikings_quiz/routes/info_page/info_box.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import 'package:vikings_quiz/routes/utils/shadow_container.dart';
import 'bloc_mocks.dart';

void main() {
  ThemeBloc themeBloc;

  setUpAll(() {
    themeBloc = MockThemeBloc();
  });

  group("Info page rendering tests", () {
    testWidgets("Making sure the page is rendered with essential widgets",
        (tester) async {
      await tester.pumpWidget(BlocProvider<ThemeBloc>.value(
          value: themeBloc,
          child: const MaterialApp(
            home: InfoPage(),
          )));

      expect(find.byType(VikingScaffold), findsOneWidget);
      expect(find.byType(ShadowContainer), findsOneWidget);
      expect(find.byType(InfoBox), findsWidgets);
    });
  });
}
