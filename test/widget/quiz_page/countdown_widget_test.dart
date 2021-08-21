import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';
import 'package:vikings_quiz/routes/quiz_page/countdown_widget.dart';
import 'package:vikings_quiz/routes/quiz_page/question.dart';
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
  });

  group("Countdown widget rendering tests", () {
    testWidgets("Testing the correct loading of the questions", (tester) async {
      when(themeBloc.state).thenReturn(DarkTheme());
      when(countdownBloc.state).thenReturn(const CountdownInProgress(3600));
      when(quizBloc.state).thenReturn(QuizReady<QuizQuestion>(const []));

      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider.value(value: quizBloc),
            BlocProvider.value(value: themeBloc),
            BlocProvider.value(value: countdownBloc),
          ],
          child: MaterialApp(
            home: VikingScaffold(
              body: CountdownTimer(),
            ),
          )));

      expect(find.text("Time left: "), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(3));
    });
  });
}
