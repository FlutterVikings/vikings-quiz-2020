import 'package:flutter/cupertino.dart';
import 'package:vikings_quiz/routes/info_page/info_box.dart';
import 'package:vikings_quiz/routes/utils/scaffold_page.dart';
import 'package:vikings_quiz/routes/utils/vertical_separator.dart';

/// Page containing information about the quiz itself and the prizes for the
/// winners
class InfoPage extends StatelessWidget {
  const InfoPage();

  @override
  Widget build(BuildContext context) {
    return VikingScaffold(
      title: "Quiz info",
      leadingIcon: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [
              VerticalSeparator(
                size: 20,
              ),
              InfoBox(
                value: 1,
                text:
                    "You are asked to answer a series of questions in a limited amount "
                    "of time. Your goal is trying to give the maximum number of correct "
                    "answers in the shortest time possible.",
              ),
              InfoBox(
                value: 2,
                text: "You cannot play the quiz more than once.",
              ),
              InfoBox(
                value: 3,
                text:
                    "Make sure to type the correct ticked ID otherwise we won't be "
                    "able to reach you in case of win.",
              ),
              InfoBox(
                value: 4,
                text:
                    "Top 3 players will receive a physical and digital copy of the "
                    "'Flutter Complete Reference' book. Top 10 players will only get "
                    "the digital version.",
              ),
              InfoBox(
                value: 5,
                text:
                    "Follow '@FlutterVikings' to stay updated on the latest news!",
              ),
              VerticalSeparator(
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
