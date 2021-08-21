import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/routes/home_page.dart';
import 'package:vikings_quiz/routes/home_page/submission_button.dart';
import 'package:vikings_quiz/routes/home_page/validation_form.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import 'package:vikings_quiz/routes/utils/shadow_container.dart';
import 'bloc_mocks.dart';

void main() {
  ThemeBloc themeBloc;
  AuthenticationBloc authenticationBloc;
  ValidationBloc validationBloc;
  TokenBloc tokenBloc;
  CountdownBloc countdownBloc;

  setUpAll(() {
    countdownBloc = MockCountdownBloc();
    tokenBloc = MockTokenBloc();
    themeBloc = MockThemeBloc();
    authenticationBloc = MockAuthBloc();
    validationBloc = MockValidationBloc();
  });

  group("Home page rendering tests", () {
    testWidgets("Making sure the page is rendered with essential widgets",
        (tester) async {
      when(authenticationBloc.state).thenReturn(const AuthenticationNoQuiz());

      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>.value(value: themeBloc),
          BlocProvider<AuthenticationBloc>.value(value: authenticationBloc),
          BlocProvider<ValidationBloc>.value(value: validationBloc),
          BlocProvider<TokenBloc>.value(value: tokenBloc),
          BlocProvider<CountdownBloc>.value(value: countdownBloc)
        ],
        child: MaterialApp(
          home: const HomePage(),
        ),
      ));

      expect(find.byType(VikingScaffold), findsOneWidget);
      expect(find.byType(SubmitTicketButton), findsNothing);
      expect(find.text("You can't play the quiz now!"), findsOneWidget);
    });

    testWidgets(
        "Making sure that no access button appear at the botton if the "
        "quiz status is disabled.", (tester) async {
      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>.value(value: themeBloc),
          BlocProvider<AuthenticationBloc>.value(value: authenticationBloc),
          BlocProvider<ValidationBloc>.value(value: validationBloc),
          BlocProvider<TokenBloc>.value(value: tokenBloc),
          BlocProvider<CountdownBloc>.value(value: countdownBloc)
        ],
        child: MaterialApp(
          home: const HomePage(),
        ),
      ));

      expect(find.byType(VikingScaffold), findsOneWidget);
      expect(find.byType(ShadowContainer), findsOneWidget);
      expect(find.byType(ValidationForm), findsOneWidget);
    });
  });
}
