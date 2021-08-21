import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vikings_quiz/routes/info_page/info_box.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import 'package:vikings_quiz/routes/utils/shadow_container.dart';

import '../bloc_mocks.dart';

void main() {
  ThemeBloc themeBloc;

  setUpAll(() {
    themeBloc = MockThemeBloc();
  });

  group("Info box rendering tests", () {
    testWidgets("Making sure widgets are properly rendered", (tester) async {
      await tester.pumpWidget(BlocProvider.value(
        value: themeBloc,
        child: MaterialApp(
          home: VikingScaffold(
            body: InfoBox(
              value: 1,
              text: "Hello test",
            ),
          ),
        ),
      ));

      // Making sure there's the number int the box
      expect(find.text("1"), findsOneWidget);

      // Making sure the text is rendered
      expect(find.text("Hello test"), findsOneWidget);

      // Boxes must be in the "Viking-styled" container
      expect(find.byType(ShadowContainer), findsOneWidget);
    });
  });
}
