import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';
import 'package:vikings_quiz/routes/quiz_page/countdown_widget.dart';
import 'package:vikings_quiz/routes/quiz_page/quiz_body.dart';
import 'package:vikings_quiz/routes/quiz_page/quiz_submission.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';

/// The page containing the questions of the game. The quiz is played inside this
/// widget, which can be seen _only_ if the user successfully authenticated.
class QuizPage extends StatelessWidget {
  const QuizPage();

  @override
  Widget build(BuildContext context) {
    return VikingScaffold(
      title: "Play",
      body: Center(
        child: Column(
          children: const [
            CountdownBox(),
            Expanded(child: QuizBody()),
            SubmitButton(),
          ],
        ),
      ),
    );
  }
}

/// Contains the countdown timer
class CountdownBox extends StatelessWidget {
  const CountdownBox();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if ((state is! QuizOver) && (state is! QuizError)) {
          return const CountdownTimer();
        }

        return const SizedBox();
      },
    );
  }
}

/// Contains the submission button (to submit quiz results) and it's hidden
/// once results have been successfully sent
class SubmitButton extends StatelessWidget {
  const SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if ((state is! QuizOver) && (state is! QuizError)) {
          return const QuizSubmission();
        }

        return const SizedBox();
      },
    );
  }
}
