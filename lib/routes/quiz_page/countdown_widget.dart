import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/countdown/bloc/countdown_bloc.dart';
import 'package:vikings_quiz/blocs/countdown/bloc/countdown_state.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';

/// A countdown timer that automatically terminates the quiz if it arrives at
/// zero.
class CountdownTimer extends StatelessWidget {
  const CountdownTimer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Time left: ",
            style: TextStyle(
              fontFamily: 'GrenzeGotisch',
              fontSize: 26,
            ),
          ),
          _CountdownText()
        ],
      ),
    );
  }
}

/// Text widget containing the countdown timer
class _CountdownText extends StatelessWidget {
  const _CountdownText();

  static const _textStyle = TextStyle(
    fontSize: 26,
    fontFamily: 'GrenzeGotisch',
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CountdownBloc, CountdownState>(
      listener: (context, state) {
        // If the counter arrives at zero, the quiz has to be ended forcefully
        if (state is CountdownCompleted) {
          context
              .read<QuizBloc>()
              .add(QuizFinished(timeLeft: state.totalSeconds));
        }
      },
      builder: (context, state) {
        // Computing values here to make the code more readable.
        // Do NOT move this directly inside a Text widget
        final minutes = state.duration.inMinutes.remainder(60);
        final seconds = state.duration.inSeconds.remainder(60);

        if (minutes > 0) {
          return Text(
            "$minutes min. $seconds sec.",
            style: _textStyle,
          );
        } else {
          return Text(
            "$seconds sec.",
            style: _textStyle,
          );
        }
      },
    );
  }
}
