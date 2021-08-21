/// Exception to be thrown when something goes wrong in the validation flow
class ValidationException implements Exception {
  /// The error message
  final String message;
  const ValidationException(this.message);
}
