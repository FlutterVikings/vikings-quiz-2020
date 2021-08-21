import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/theme/theme.dart';

/// A container (with a shadow) whose color changes according with the theme
class ShadowContainer extends StatelessWidget {
  /// The child widget (content of the container)
  final Widget child;

  /// The maximum allowed width for a fixed size container.
  ///
  /// The container has a default, fixed width (350.0) but for responsiveness,
  /// in case there weren't enough room, the width is scaled down by a factor of
  /// 1.2 (to avoid overflows).
  final double breakPoint;
  const ShadowContainer({@required this.child, this.breakPoint = 350.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, sizes) {
        var containerWidth = breakPoint;

        if (sizes.maxWidth < (breakPoint - 20)) {
          containerWidth = sizes.maxWidth / 1.2;
        }

        return SingleChildScrollView(child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            var color = Color.fromRGBO(240, 240, 240, 1);

            if (state is DarkTheme) {
              color = Color.fromRGBO(33, 33, 33, 1);
            }

            return Container(
              width: containerWidth,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: const [BoxShadow(blurRadius: 10)]),
              child: child,
            );
          },
        ));
      },
    );
  }
}
