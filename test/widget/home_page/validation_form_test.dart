import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/routes/home_page/submission_button.dart';
import 'package:vikings_quiz/routes/home_page/validation_form.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import '../bloc_mocks.dart';

void main() {
  AuthenticationBloc authenticationBloc;
  ValidationBloc validationBloc;
  TokenBloc tokenBloc;
  ThemeBloc themeBloc;

  setUpAll(() {
    authenticationBloc = MockAuthBloc();
    validationBloc = MockValidationBloc();
    tokenBloc = MockTokenBloc();
    themeBloc = MockThemeBloc();
  });

  group("Validation form rendering tests", () {
    testWidgets("While the validation is running, no buttons must appear",
        (tester) async {
      when(tokenBloc.state).thenReturn("");
      when(authenticationBloc.state).thenReturn(const AuthenticationLoading());
      when(themeBloc.state).thenReturn(DarkTheme());
      when(validationBloc.state).thenReturn(const ValidationNone());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: tokenBloc),
            BlocProvider.value(value: authenticationBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: validationBloc),
          ],
          child: const MaterialApp(
            home: VikingScaffold(
              body: ValidationForm(),
            ),
          )));

      // Show the text field and a loading indicator
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsWidgets);

      // No buttons must appear
      expect(find.byType(SubmitTicketButton), findsNothing);
      expect(find.byKey(Key("validation_form_info")), findsNothing);
    });

    testWidgets("If the validation suceeded, the buttons must appear",
        (tester) async {
      when(tokenBloc.state).thenReturn("");
      when(authenticationBloc.state)
          .thenReturn(const AuthenticationDoneLoading());
      when(themeBloc.state).thenReturn(DarkTheme());
      when(validationBloc.state).thenReturn(const ValidationNone());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: tokenBloc),
            BlocProvider.value(value: authenticationBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: validationBloc),
          ],
          child: const MaterialApp(
            home: VikingScaffold(
              body: ValidationForm(),
            ),
          )));

      // Show the text field
      expect(find.byType(TextFormField), findsOneWidget);

      // Buttons must appear
      expect(find.byType(SubmitTicketButton), findsOneWidget);
      expect(find.byKey(Key("validation_form_info")), findsOneWidget);
    });
  });
}
