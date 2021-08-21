/// Simple utility class that gathers various configuration strings
abstract class ConfigurationValues {
  ConfigurationValues._();

  /// The secret key for the TITO API
  static const String titoSecret = "production_secret_placeholder";

  /// Total questions on Firestore
  static const int totalQuizQuestions = 65;

  /// Questions to be randomly picked
  static const int questionsToBePicked = 9;

  /// How long the quiz can last
  static const Duration totalQuizDuration = Duration(minutes: 8);

  /// The timeout for Firebase calls
  static const Duration httpTimeout = Duration(seconds: 4);
}
