import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';
import 'package:vikings_quiz/routes/quiz_page/question.dart';
import 'package:vikings_quiz/routes/quiz_page/quiz_body.dart';
import 'package:vikings_quiz/routes/utils/error_container.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import 'package:vikings_quiz/routes/utils/shadow_container.dart';
import '../bloc_mocks.dart';

void main() {
  QuizBloc quizBloc;
  CountdownBloc countdownBloc;
  ThemeBloc themeBloc;

  setUpAll(() {
    countdownBloc = MockCountdownBloc();
    quizBloc = MockQuizBloc();
    themeBloc = MockThemeBloc();
  });

  group("Quiz game logic rendering tests", () {
    testWidgets("Testing the correct loading of the questions", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());
      when(countdownBloc.state).thenReturn(const CountdownInProgress(3600));
      when(quizBloc.state).thenReturn(QuizReady<QuizQuestion>(const [
        QuizQuestion.fromData(question: "Question 1", correctAnswer: true),
        QuizQuestion.fromData(question: "Question 2", correctAnswer: false),
      ]));

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: quizBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: QuizBody(),
            ),
          )));

      // Expecting to find 2 'Question' items because the stub state 'QuizReady'
      // has 2 objects in the list
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Question), findsNWidgets(2));
    });

    testWidgets("Testing the error handling", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());
      when(countdownBloc.state).thenReturn(const CountdownInProgress(3600));
      when(quizBloc.state).thenReturn(const QuizError("Error"));

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: quizBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: QuizBody(),
            ),
          )));

      expect(find.text("Error"), findsOneWidget);
      expect(find.byType(ShadowContainer), findsOneWidget);
    });

    testWidgets("Testing the submission of the quiz", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());
      when(countdownBloc.state).thenReturn(const CountdownInProgress(3600));
      when(quizBloc.state).thenReturn(const QuizOver());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: quizBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: QuizBody(),
            ),
          )));

      expect(find.text("You have successfully submitted your attempt!"),
          findsOneWidget);
      expect(find.byType(ShadowContainer), findsOneWidget);
    });

    testWidgets("Testing the submission error", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());
      when(countdownBloc.state).thenReturn(const CountdownInProgress(3600));
      when(quizBloc.state).thenReturn(const QuizSubmitError(3600));

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: quizBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: QuizBody(),
            ),
          )));

      expect(find.byType(ErrorContainer), findsOneWidget);
      expect(find.byType(ShadowContainer), findsOneWidget);

      await tester.tap(find.byKey(Key("error_button_callback")));
      verify(quizBloc.add(QuizFinished(timeLeft: 3600))).called(1);
    });

    testWidgets("Test while the quiz is loading", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());
      when(countdownBloc.state).thenReturn(const CountdownInProgress(3600));
      when(quizBloc.state).thenReturn(const QuizLoading());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: quizBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: QuizBody(),
            ),
          )));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
