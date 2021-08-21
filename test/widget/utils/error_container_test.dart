import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vikings_quiz/routes/utils/error_container.dart';

void main() {
  const errorMsg = "An error msg";
  const defaultMsg = "Something went wrong! :(";

  group("Error dialog rendering tests", () {
    testWidgets("Ensuring it has an icon, the text and a callback",
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ErrorContainer(
          errorMessage: errorMsg,
          buttonCallback: () {},
        ),
      ));

      // There must be the icon, the text and a callback button
      expect(find.text(errorMsg), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(RaisedButton), findsOneWidget);
    });

    testWidgets("Testing the default error message", (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ErrorContainer(
          buttonCallback: () {},
        ),
      ));

      // The default error message
      expect(find.text(defaultMsg), findsOneWidget);
    });
  });
}
