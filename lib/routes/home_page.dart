import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/authentication/authentication.dart';
import 'package:vikings_quiz/blocs/quiz/bloc/quiz_bloc.dart';
import 'package:vikings_quiz/blocs/quiz/bloc/quiz_event.dart';
import 'package:vikings_quiz/blocs/token/token.dart';
import 'package:vikings_quiz/blocs/validation/validation.dart';
import 'package:vikings_quiz/configurations.dart';
import 'package:vikings_quiz/routes.dart';
import 'package:vikings_quiz/routes/home_page/validation_form.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import 'package:vikings_quiz/routes/utils/shadow_container.dart';

/// Home page of the app which requires the validation of a ticket token.
class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSucceeded) {
          // Move to the quiz page
          Navigator.of(context).pushNamed(RouteGenerator.quizPage);

          // Start the game!
          context.read<QuizBloc>().add(
                QuizStarted(
                    tokenId: context.read<TokenBloc>().state,
                    totalGameDuration:
                        ConfigurationValues.totalQuizDuration.inSeconds,
                    totalQuestions: ConfigurationValues.totalQuizQuestions,
                    toBePicked: ConfigurationValues.questionsToBePicked),
              );
        }
      },
      child: const _HomePageBody(),
    );
  }
}

/// The actual body of the page
class _HomePageBody extends StatefulWidget {
  const _HomePageBody();

  @override
  __HomePageBodyState createState() => __HomePageBodyState();
}

class __HomePageBodyState extends State<_HomePageBody> {
  // We cache the validation form subtree so that it doesn't get rebuilt too
  // many times in case the user changed the theme too often
  Widget cachedSubtree;

  @override
  void initState() {
    super.initState();

    cachedSubtree = BlocProvider<ValidationBloc>(
      create: (_) => ValidationBloc(
        //validationRepository: const TicketRepository(),
        validationRepository: const MockAuthRepository(true),
        authenticationBloc: context.read<AuthenticationBloc>(),
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: ValidationForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VikingScaffold(
      body: Center(
        child: ShadowContainer(
          child: cachedSubtree,
        ),
      ),
    );
  }
}
