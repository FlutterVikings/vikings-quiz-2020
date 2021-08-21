import 'package:flutter/material.dart';
import 'package:vikings_quiz/blocs/validation/validation.dart';
import 'validation_repository.dart';

/// A "fake" authentication provider which is intended to be used as mock when
/// writing tests.
class MockAuthRepository extends ValidationRepository {
  /// Determines whether the fake authentication will fail or not
  final bool success;
  const MockAuthRepository(this.success);

  @override
  Future<bool> validate({@required String token}) async {
    await Future.delayed(const Duration(seconds: 2));
    return success;
  }
}
