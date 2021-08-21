import 'package:flutter/material.dart';
import 'package:vikings_quiz/routes/quiz_page/list_tiles.dart';
import 'package:vikings_quiz/routes/utils/horizontal_separator.dart';
import 'package:vikings_quiz/routes/utils/shadow_container.dart';

/// A widget representing a question of the quiz.
class Question extends StatelessWidget {
  /// The index of the question
  final int index;

  /// The text of the question
  final String question;

  /// The code (if present) associated to the question
  final String code;
  const Question({
    @required this.index,
    @required this.question,
    this.code = "",
  });

  /// Decides when building the widget
  static const _boxBreakPoint = 450.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShadowContainer(
        breakPoint: _boxBreakPoint,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 20),
                child: Text(
                  "Question ${index + 1}",
                  style: const TextStyle(
                    fontSize: 26,
                    fontFamily: "GrenzeGotisch",
                  ),
                ),
              ),

              // Question
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(question),
              ),

              const HorizontalSeparator(
                size: 20,
              ),

              if (code.length > 0)
                Center(
                  child: Image.network(
                    code,
                    width: _boxBreakPoint - 100,
                    frameBuilder: (context, child, frame, syncLoaded) {
                      if (syncLoaded) {
                        return child;
                      }

                      return AnimatedSwitcher(
                        child: frame == null ? const ImagePlaceholder() : child,
                        duration: const Duration(milliseconds: 400),
                        transitionBuilder: (widget, animation) =>
                            ScaleTransition(
                          scale: animation,
                          child: widget,
                        ),
                      );
                    },
                    errorBuilder: (context, _, __) => const ImageLoadError(),
                  ),
                ),

              if (code.length > 0)
                const HorizontalSeparator(
                  size: 20,
                ),

              const Divider(
                height: 40,
                thickness: 1,
              ),

              // Options
              ListTiles(index),

              // End
            ],
          ),
        ),
      ),
    );
  }
}

/// Loading spinner to be displayed while the image is being fetched
class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: CircularProgressIndicator(),
    );
  }
}

/// Loading spinner to be displayed while the image is being fetched
class ImageLoadError extends StatelessWidget {
  const ImageLoadError();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Text("Couldn't load the image :("),
    );
  }
}
