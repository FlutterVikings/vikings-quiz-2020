import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/token/bloc/token_bloc.dart';
import 'package:vikings_quiz/blocs/validation/validation.dart';

/// Submission button of the form
class SubmitTicketButton extends StatelessWidget {
  const SubmitTicketButton();

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Error",
              style: TextStyle(fontFamily: "GrenzeGotisch"),
            ),
            content:
                const Text("Whoops! Check your ticket code and try again!"),
            actions: [
              RaisedButton(
                child: const Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ValidationBloc, ValidationState>(
        listener: (context, state) {
      if (state is ValidationFailed) {
        _showAlert(context);
      }
    }, builder: (context, state) {
      if (state is ValidationLoading) {
        return const CircularProgressIndicator();
      }

      return BlocBuilder<TokenBloc, String>(
        builder: (context, state) {
          return RaisedButton(
            key: Key("submission_form_ok"),
            child: const Text("OK"),
            onPressed: () => context.read<ValidationBloc>().add(ValidationEvent(
                  token: state,
                )),
          );
        },
      );
    });
  }
}
