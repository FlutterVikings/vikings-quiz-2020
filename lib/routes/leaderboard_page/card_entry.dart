import 'package:flutter/material.dart';
import 'package:vikings_quiz/routes/leaderboard_page/result_card.dart';
import 'package:vikings_quiz/routes/utils/horizontal_separator.dart';

/// A simple widget that shows a bold title with a value next to it.
///
/// It's meant to be used inside a [ResultCard] widget to better display multiple
/// data in a "key-value" fashion
class CardEntry extends StatelessWidget {
  /// The bold title
  final String title;

  /// The value
  final String value;

  /// The padding that surrounds the content of the widget
  final EdgeInsets edgeInsets;
  const CardEntry({
    @required this.title,
    @required this.value,
    this.edgeInsets = const EdgeInsets.only(top: 5, bottom: 5),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsets,
      child: Center(
        child: Row(
          children: [
            Text(
              "$title:",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: "GrenzeGotisch",
                  fontSize: 20,
                  color: Colors.cyan),
            ),
            const HorizontalSeparator(
              size: 5,
            ),
            Expanded(
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "GrenzeGotisch",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
