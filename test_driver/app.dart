import 'package:flutter_driver/driver_extension.dart';
import 'package:vikings_quiz/main.dart' as vikings_app;

void main() {
  enableFlutterDriverExtension();

  // Enabling the driver for the main app
  vikings_app.main();
}
