import 'package:flutter/material.dart';
import 'package:vikings_quiz/routes/utils/shadow_container.dart';

/// A box displaying a rounded number on the left and some text on the right
class InfoBox extends StatelessWidget {
  /// The number to be displayed
  final int value;

  /// The text
  final String text;
  const InfoBox({
    @required this.value,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
      child: ShadowContainer(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text("$value"),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Text(text),
              )
            ],
          ),
        ),
      ),
    );
  }
}
