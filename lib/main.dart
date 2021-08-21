import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:vikings_quiz/blocs/authentication/authentication.dart';
import 'package:vikings_quiz/blocs/countdown/countdown.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';
import 'package:vikings_quiz/blocs/quiz/models/results/firebase_results_repository.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';
import 'package:vikings_quiz/blocs/theme/theme.dart';
import 'package:vikings_quiz/blocs/token/token.dart';
import 'package:vikings_quiz/routes.dart';

void main() async {
  // Initializing HydratedBloc's storage
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();

  // Running the app itself
  runApp(const VikingsQuiz());
}

/// The root widget of the app
class VikingsQuiz extends StatelessWidget {
  const VikingsQuiz();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Manages the authentication state
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc()..add(const AppStarted()),
        ),

        // Manages the theme state of the app
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(),
        ),

        // Countdown timer for the quiz
        BlocProvider<CountdownBloc>(
          create: (_) => CountdownBloc(
            counter: const Counter(),
          ),
        ),

        // "Stores" the token of the user
        BlocProvider<TokenBloc>(
          create: (_) => TokenBloc(tokenRepository: TitoTokenRepository()),
        ),

        // The players' scores leaderboard
        BlocProvider<LeaderboardBloc>(
            create: (_) =>
                LeaderboardBloc(repository: FirebaseLeaderboardRepository())),
      ],
      child: const _MaterialWidget(),
    );
  }
}

/// The material widget containing the whole app. It also applies the "light" or
/// "dark" theme, which is determined according with the state of the bloc.
class _MaterialWidget extends StatelessWidget {
  const _MaterialWidget();

  @override
  Widget build(BuildContext context) {
    // The 'BlocProvider<QuizBloc>' instance had to be put here because of the
    // reference to the 'CountdownBloc.
    //
    // If this bloc were initialized above inside the MultiBlocProvider, there
    // wouldn't have been the possibility to inject the dependency
    return BlocProvider<QuizBloc>(
      create: (_) => QuizBloc<QuizQuestion>(
        questionRepository: FirebaseQuestionRepository(),
        resultsRepository: FirebaseResultsRepository(),
        countdownBloc: context.read<CountdownBloc>(),
      ),
      // Changes the theme across the entire app
      child: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return MaterialApp(
            onGenerateRoute: RouteGenerator.generateRoute,
            onGenerateTitle: (_) => "Vikings Quiz",
            initialRoute: RouteGenerator.homePage,
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
          );
        },
      ),
    );
  }
}
