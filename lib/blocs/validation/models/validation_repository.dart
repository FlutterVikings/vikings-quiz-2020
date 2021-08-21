import 'package:flutter/material.dart';

/// Implements the 'Strategy Pattern' to define an abstraction for a validation
/// provider.
abstract class ValidationRepository {
  const ValidationRepository();

  /// Performs the authentication using a certain provider
  Future<bool> validate({@required String token});
}
