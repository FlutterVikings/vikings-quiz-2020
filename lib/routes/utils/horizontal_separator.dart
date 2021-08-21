import 'package:flutter/material.dart';

/// A simple spacer widget that adds space between two widgets in the horizontal
/// direction. This is often used inside [Row] or [ListView] in the horizontal
/// direction
class HorizontalSeparator extends StatelessWidget {
  /// The gap to add between widgets
  final double size;
  const HorizontalSeparator({this.size = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
    );
  }
}
