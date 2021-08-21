/// Exception to be thrown when something goes wrong in the authentication flow
class AuthenticationException implements Exception {
  /// The error message
  final String message;
  const AuthenticationException(this.message);
}
