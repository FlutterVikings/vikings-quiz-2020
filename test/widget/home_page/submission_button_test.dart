import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/routes/home_page/submission_button.dart';
import '../bloc_mocks.dart';

void main() {
  ValidationBloc validationBloc;
  AuthenticationBloc authenticationBloc;
  TokenBloc tokenBloc;

  setUpAll(() {
    validationBloc = MockValidationBloc();
    authenticationBloc = MockAuthBloc();
    tokenBloc = MockTokenBloc();
  });

  group("Form submission button rendering tests", () {
    testWidgets(
        "While the validation is running, a progress indicator must appear",
        (tester) async {
      when(tokenBloc.state).thenReturn("abc");
      when(authenticationBloc.state)
          .thenReturn(const AuthenticationDoneLoading());
      when(validationBloc.state).thenReturn(const ValidationLoading());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: tokenBloc),
            BlocProvider.value(value: authenticationBloc),
            BlocProvider.value(value: validationBloc),
          ],
          child: const MaterialApp(
            home: SubmitTicketButton(),
          )));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(RaisedButton), findsNothing);
    });

    testWidgets(
        "While the validation is NOT running, a 'submit' button must appear",
        (tester) async {
      when(tokenBloc.state).thenReturn("abc");
      when(authenticationBloc.state)
          .thenReturn(const AuthenticationDoneLoading());
      when(validationBloc.state).thenReturn(const ValidationNone());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: tokenBloc),
            BlocProvider.value(value: authenticationBloc),
            BlocProvider.value(value: validationBloc),
          ],
          child: const MaterialApp(
            home: SubmitTicketButton(),
          )));

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(RaisedButton), findsOneWidget);

      // Tapping on the button
      await tester.tap(find.byType(RaisedButton));
      verify(validationBloc.add(const ValidationEvent(token: "abc"))).called(1);
    });
  });
}
