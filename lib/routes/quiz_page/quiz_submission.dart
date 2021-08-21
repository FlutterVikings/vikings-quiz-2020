import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vikings_quiz/blocs/countdown/bloc/countdown_bloc.dart';
import 'package:vikings_quiz/blocs/countdown/bloc/countdown_event.dart';
import 'package:vikings_quiz/blocs/countdown/bloc/countdown_state.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';

/// Button that terminates the quiz
class QuizSubmission extends StatelessWidget {
  const QuizSubmission();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: _QuizSubmitButton(),
      ),
    );
  }
}

/// Button used to terminate the quiz and send the results
class _QuizSubmitButton extends StatelessWidget {
  const _QuizSubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountdownBloc, CountdownState>(
      buildWhen: (previous, current) {
        return (previous != current) && (current is CountdownInProgress);
      },
      builder: (context, state) {
        return RaisedButton(
          child: const Text("Finish the quiz"),
          onPressed: () {
            // Stop the timer
            context.read<CountdownBloc>().add(const CountdownStopped());

            // Submit the results
            context
                .read<QuizBloc>()
                .add(QuizFinished(timeLeft: state.totalSeconds));
          },
        );
      },
    );
  }
}
