/// Handles tokens received by the user
abstract class TokenRepository {
  /// Gets the token
  String get token;

  /// Validates and writes the value of the token
  void set token(String value);
}
