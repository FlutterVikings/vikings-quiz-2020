import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';

/// Represents a 'True/False' form box in which options are mutually exclusive.
class ListTiles extends StatelessWidget {
  /// The index of the question
  final int index;
  const ListTiles(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        var radioValue = -1;

        if (state.answers.containsKey(index)) {
          radioValue = state.answers[index] ? 1 : 0;
        }

        return Column(mainAxisSize: MainAxisSize.min, children: [
          // False
          ListTile(
            title: const Text("False"),
            leading: Radio<int>(
              key: Key("question_radio_false"),
              groupValue: radioValue,
              value: 0,
              onChanged: (_) => context
                  .read<QuizBloc>()
                  .add(NewAnswer(questionIndex: index, answer: false)),
            ),
          ),

          // True
          ListTile(
            title: const Text("True"),
            leading: Radio<int>(
              key: Key("question_radio_true"),
              groupValue: radioValue,
              value: 1,
              onChanged: (_) => context
                  .read<QuizBloc>()
                  .add(NewAnswer(questionIndex: index, answer: true)),
            ),
          ),
        ]);
      },
    );
  }
}
