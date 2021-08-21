import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/authentication/models/initialization_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

/// Bloc that handles the authentication flow moving the user from an auth page
/// to the contents of the app itself.
///
/// Initializations of packages is done here when the [AppStarted] event is
/// emitted.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final bool performStartupInit;
  AuthenticationBloc({this.performStartupInit = true})
      : super(const AuthenticationDoneLoading());

  static const _initRepo = InitializationRepository();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield const AuthenticationLoading();

      if (performStartupInit) {
        await _initRepo.execute();

        // Checking whether the quiz can be played or not
        final isDisabled = await _initRepo.isQuizDisabled();

        if (isDisabled) {
          yield const AuthenticationNoQuiz();
        } else {
          yield const AuthenticationDoneLoading();
        }
      } else {
        yield const AuthenticationDoneLoading();
      }
    }

    if (event is ValidationSucceeded) {
      yield const AuthenticationSucceeded();
      yield const AuthenticationDoneLoading();
    }
  }
}
