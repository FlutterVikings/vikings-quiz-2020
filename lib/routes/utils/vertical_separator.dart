import 'package:flutter/cupertino.dart';

/// A simple spacer widget that adds space between two widgets in the vertical
/// direction. This is often used inside [Column] or [ListView],
class VerticalSeparator extends StatelessWidget {
  /// The gap to add between widgets
  final double size;
  const VerticalSeparator({this.size = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}
