import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/quiz/quiz.dart';
import 'package:vikings_quiz/routes.dart';
import 'package:vikings_quiz/routes/quiz_page/question.dart';
import 'package:vikings_quiz/routes/utils/error_container.dart';
import 'package:vikings_quiz/routes/utils/shadow_container.dart';
import 'package:vikings_quiz/routes/utils/vertical_separator.dart';

/// The widget containing the quiz itself. It's made up of a series of a slideable
/// boxes containing the questions and the answers of the quiz.
class QuizBody extends StatelessWidget {
  const QuizBody();

  /// Decides when building the widget
  bool _buildCondition(QuizState previous, QuizState current) {
    return (previous != current) && (current is! AnswerGiven);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: BlocBuilder<QuizBloc, QuizState>(
          buildWhen: _buildCondition,
          builder: (context, state) {
            // Questions loaded successfully
            if (state is QuizReady<QuizQuestion>) {
              final questions = state.questionsList;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Question(
                      index: index,
                      question: questions[index].question,
                      code: questions[index].code,
                    ),
                  );
                },
              );
            }

            // Error
            if (state is QuizError) {
              return Center(
                child: ShadowContainer(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: ErrorContainer(
                      errorMessage: state.message,
                      buttonCallback: () => Navigator.of(context)
                          .pushReplacementNamed(RouteGenerator.homePage),
                    ),
                  ),
                ),
              );
            }

            // Quiz finished
            if (state is QuizOver) {
              return Center(child: const _SubmissionSuccessContainer());
            }

            // The repository couldn't store the data
            if (state is QuizSubmitError) {
              return Center(
                child: ShadowContainer(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: ErrorContainer(
                      errorMessage:
                          "Whoops, we couldn't connect to the server :( Please "
                          "check your connection and try again!",
                      buttonCallback: () => context
                          .read<QuizBloc>()
                          .add(QuizFinished(timeLeft: state.totalSecondsLeft)),
                    ),
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

/// A [ShadowContainer] telling the user that the quiz result have successfully
/// been stored by the repository
class _SubmissionSuccessContainer extends StatelessWidget {
  const _SubmissionSuccessContainer();

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 35,
              ),
              const VerticalSeparator(
                size: 20,
              ),
              const Text("You have successfully submitted your attempt!"),
              const VerticalSeparator(
                size: 20,
              ),
              RaisedButton(
                child: const Text("Home page"),
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(RouteGenerator.homePage),
              )
            ],
          ),
        ),
      ),
    );
  }
}
