import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/authentication/authentication.dart';
import '../models/validation_repository.dart';
import 'validation_event.dart';
import 'validation_state.dart';

/// A typical "login bloc" which takes care of validating an user in case given
/// token ID is valid.
///
/// This bloc handles the validation state (which is basically the state of the
/// buttons on the form) while [AuthenticationBloc] takes care of moving to other
/// app pages.
class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  /// Repository used to validate a token
  final ValidationRepository validationRepository;

  /// Reference required in order to tell the [AuthenticationBloc] the state of
  /// the validation.
  final AuthenticationBloc authenticationBloc;

  ValidationBloc({
    @required this.validationRepository,
    @required this.authenticationBloc,
  }) : super(const ValidationNone());

  @override
  Stream<ValidationState> mapEventToState(ValidationEvent event) async* {
    yield const ValidationLoading();

    // Validating the token
    final isValid = await validationRepository.validate(token: event.token);

    if (isValid) {
      // Move to the quiz page because the authentication succeeded
      authenticationBloc.add(const ValidationSucceeded());
    } else {
      // The validation failed
      yield const ValidationFailed("The validation phase failed.");
    }

    yield const ValidationNone();
  }
}
