import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import '../bloc_mocks.dart';

void main() {
  ThemeBloc themeBloc;

  setUpAll(() {
    themeBloc = MockThemeBloc();
  });

  group("Custom scaffold tests", () {
    testWidgets("Making sure there's a title and a Stack as body",
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<ThemeBloc>.value(
          value: themeBloc,
          child: VikingScaffold(
            body: Container(),
          ),
        ),
      ));

      // The appbar must have the default title
      expect(find.text("Vikings Quiz"), findsOneWidget);

      // There must be a stack to "host" the background image
      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(Image), findsWidgets);

      // No FAB specified
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets("Making sure the FAB appears", (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<ThemeBloc>.value(
          value: themeBloc,
          child: VikingScaffold(
            body: Container(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
            ),
          ),
        ),
      ));

      // The appbar must have the default title
      expect(find.text("Vikings Quiz"), findsOneWidget);

      // There must be a stack to "host" the background image
      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(Image), findsWidgets);

      // No FAB specified
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets("Making sure the custom title is properly rendered",
        (tester) async {
      final title = "Test title";

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<ThemeBloc>.value(
          value: themeBloc,
          child: VikingScaffold(
            title: title,
            body: Container(),
          ),
        ),
      ));

      // Check the appbar's title
      expect(find.text(title), findsOneWidget);
    });

    testWidgets("Making sure the Light-To-Dark theme change is correct",
        (tester) async {
      // Setup the "light" theme state
      when(themeBloc.state).thenReturn(LightTheme());

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<ThemeBloc>.value(
          value: themeBloc,
          child: VikingScaffold(
            title: "Test",
            body: Container(),
          ),
        ),
      ));

      // Tapping the button to switch to the dark theme
      await tester.tap(find.byKey(Key("viking_scaffold_dark_button")));

      // Expecting the event to be called once on the bloc
      verify(themeBloc.add(const LightEvent())).called(1);
    });

    testWidgets("Making sure the Dark-To-Light theme change is correct",
        (tester) async {
      // Setup the "dart" theme state
      when(themeBloc.state).thenReturn(DarkTheme());

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<ThemeBloc>.value(
          value: themeBloc,
          child: VikingScaffold(
            title: "Test",
            body: Container(),
          ),
        ),
      ));

      // Tapping the button to switch to the dark theme
      await tester.tap(find.byKey(Key("viking_scaffold_light_button")));

      // Expecting the event to be called once on the bloc
      verify(themeBloc.add(const DarkEvent())).called(1);
    });
  });
}
