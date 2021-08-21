import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';
import 'package:vikings_quiz/routes/quiz_page.dart';
import 'package:vikings_quiz/routes/quiz_page/countdown_widget.dart';
import 'package:vikings_quiz/routes/quiz_page/quiz_submission.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import 'bloc_mocks.dart';

void main() {
  ThemeBloc themeBloc;
  CountdownBloc countdownBloc;
  QuizBloc quizBloc;

  setUpAll(() {
    themeBloc = MockThemeBloc();
    countdownBloc = MockCountdownBloc();
    quizBloc = MockQuizBloc();
  });

  group("Info page rendering tests", () {
    testWidgets("Making sure the page rendered with a custom Scaffold",
        (tester) async {
      when(countdownBloc.state).thenReturn(const CountdownInProgress(10));

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
            BlocProvider.value(value: quizBloc),
          ],
          child: const MaterialApp(
            home: QuizPage(),
          )));

      expect(find.byType(VikingScaffold), findsOneWidget);
      expect(find.byType(CountdownBox), findsOneWidget);
      expect(find.byType(SubmitButton), findsWidgets);
    });

    testWidgets(
        "Making sure the countdown timer and the submit button are NOT "
        "displayed when the quiz is over", (tester) async {
      when(countdownBloc.state).thenReturn(const CountdownCompleted());
      when(quizBloc.state).thenReturn(const QuizOver());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
            BlocProvider.value(value: quizBloc),
          ],
          child: const MaterialApp(
            home: QuizPage(),
          )));

      // In case of gameover, there cannot be the timer and the submit button
      expect(find.byType(CountdownTimer), findsNothing);
      expect(find.byType(QuizSubmission), findsNothing);

      // The outer widget instead must be visible but it will return something
      // else like a Container or a SizedBox
      expect(find.byType(CountdownBox), findsOneWidget);
      expect(find.byType(SubmitButton), findsWidgets);
    });

    testWidgets(
        "Making sure the countdown timer and the submit button are NOT "
        "displayed when there's an error", (tester) async {
      when(countdownBloc.state).thenReturn(const CountdownCompleted());
      when(quizBloc.state).thenReturn(const QuizError("Exception"));

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
            BlocProvider.value(value: quizBloc),
          ],
          child: const MaterialApp(
            home: QuizPage(),
          )));

      // In case of error, there cannot be the timer and the submit button
      expect(find.byType(CountdownTimer), findsNothing);
      expect(find.byType(QuizSubmission), findsNothing);

      // The outer widget instead must be visible but it will return something
      // else like a Container or a SizedBox
      expect(find.byType(CountdownBox), findsOneWidget);
      expect(find.byType(SubmitButton), findsWidgets);
    });
  });
}
