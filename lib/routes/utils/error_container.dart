import 'package:flutter/material.dart';
import 'package:vikings_quiz/routes/utils/vertical_separator.dart';

/// Shows an error dialog at the center of the screen
class ErrorContainer extends StatelessWidget {
  /// The error message to be shown in the container
  final String errorMessage;

  /// The callback associated to the button at the bottom of the dialog
  final void Function() buttonCallback;
  const ErrorContainer({
    this.errorMessage = "Something went wrong! :(",
    this.buttonCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error,
              color: Colors.redAccent,
              size: 35,
            ),
            const VerticalSeparator(
              size: 20,
            ),
            Text(
              errorMessage,
              key: Key("error_container_message"),
            ),
            const VerticalSeparator(
              size: 25,
            ),
            if (buttonCallback != null)
              RaisedButton(
                key: Key("error_button_callback"),
                child: const Text("OK"),
                onPressed: buttonCallback,
              )
          ],
        ),
      ),
    );
  }
}
