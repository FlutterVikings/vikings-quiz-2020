import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';
import 'package:vikings_quiz/routes/quiz_page/list_tiles.dart';
import 'package:vikings_quiz/routes/quiz_page/question.dart';
import 'package:vikings_quiz/routes/utils/horizontal_separator.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import '../bloc_mocks.dart';

void main() {
  QuizBloc quizBloc;
  CountdownBloc countdownBloc;
  ThemeBloc themeBloc;

  setUpAll(() {
    countdownBloc = MockCountdownBloc();
    quizBloc = MockQuizBloc();
    themeBloc = MockThemeBloc();

    when(quizBloc.state).thenReturn(QuizReady<QuizQuestion>(
        [QuizQuestion.fromData(question: "Question", correctAnswer: true)]));
  });

  group("Question rendering tests", () {
    testWidgets("Testing the rendering of the questions", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: quizBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: Question(
                index: 1,
                question: "Question",
              ),
            ),
          )));

      expect(find.text("Question"), findsOneWidget);
      expect(find.byType(HorizontalSeparator), findsOneWidget);

      // The header
      expect(find.text("Question 2"), findsOneWidget);

      expect(find.byType(ListTiles), findsOneWidget);
      expect(find.byKey(Key("question_radio_false")), findsOneWidget);
      expect(find.byKey(Key("question_radio_true")), findsOneWidget);
    });

    testWidgets("Testing the button tap (The 'false' radio option)",
        (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: quizBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: Question(
                index: 1,
                question: "Question",
              ),
            ),
          )));

      expect(find.byType(ListTiles), findsOneWidget);

      await tester.tap(find.byKey(Key("question_radio_false")));
      verify(quizBloc.add(NewAnswer(questionIndex: 1, answer: false)))
          .called(1);
    });

    testWidgets("Testing the button tap (The 'true' radio option)",
        (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: quizBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: Question(
                index: 3,
                question: "Question",
              ),
            ),
          )));

      expect(find.byType(ListTiles), findsOneWidget);

      await tester.tap(find.byKey(Key("question_radio_true")));
      verify(quizBloc.add(NewAnswer(questionIndex: 3, answer: true))).called(1);
    });
  });
}
