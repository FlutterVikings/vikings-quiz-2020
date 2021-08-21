import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';
import 'package:vikings_quiz/routes.dart';
import 'package:vikings_quiz/routes/home_page.dart';
import 'package:vikings_quiz/routes/info_page.dart';
import 'package:vikings_quiz/routes/leaderboard_page.dart';
import 'package:vikings_quiz/routes/quiz_page.dart';
import 'bloc_mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  NavigatorObserver mockObserver;

  AuthenticationBloc authenticationBloc;
  CountdownBloc countdownBloc;
  LeaderboardBloc leaderboardBloc;
  QuizBloc quizBloc;
  ThemeBloc themeBloc;
  TokenBloc tokenBloc;
  ValidationBloc validationBloc;

  setUp(() {
    mockObserver = MockNavigatorObserver();

    authenticationBloc = MockAuthBloc();
    countdownBloc = MockCountdownBloc();
    leaderboardBloc = MockLeaderboardBloc();
    quizBloc = MockQuizBloc();
    themeBloc = MockThemeBloc();
    tokenBloc = MockTokenBloc();
    validationBloc = MockValidationBloc();
  });

  Future<void> _buildHome(WidgetTester tester) async {
    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authenticationBloc),
        BlocProvider.value(value: countdownBloc),
        BlocProvider.value(value: leaderboardBloc),
        BlocProvider.value(value: quizBloc),
        BlocProvider.value(value: themeBloc),
        BlocProvider.value(value: tokenBloc),
        BlocProvider.value(value: validationBloc),
      ],
      child: MaterialApp(
        home: HomePage(),
        onGenerateRoute: RouteGenerator.generateRoute,
        onGenerateTitle: (_) => "Vikings Quiz",
        initialRoute: RouteGenerator.homePage,
        navigatorObservers: [mockObserver],
      ),
    ));

    verify(mockObserver.didPush(any, any));
  }

  group("Testing the app's routes", () {
    testWidgets("Testing the routing on the 'Info' page", (tester) async {
      await _buildHome(tester);

      await tester.tap(find.byKey(Key("validation_form_info")));
      await tester.pumpAndSettle();

      // Test
      expect(find.byType(InfoPage), findsOneWidget);
      verify(mockObserver.didPush(any, any)).called(1);
    });

    testWidgets("Testing the routing on the 'Leaderboards' page",
        (tester) async {
      await _buildHome(tester);

      // Stub response (assuming no results returned for convenience)
      when(leaderboardBloc.state).thenReturn(const LeaderboardLoaded([]));

      await tester.tap(find.byKey(Key("viking_scaffold_leaderboard_button")));
      await tester.pumpAndSettle();

      expect(find.byType(LeaderboardPage), findsOneWidget);
      verify(mockObserver.didPush(any, any)).called(1);
    });
  });
}
