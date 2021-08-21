import 'package:equatable/equatable.dart';
import 'authentication_bloc.dart';

/// Events for the [AuthenticationBloc] bloc
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

/// Event fired when the app is started for the first time
class AppStarted extends AuthenticationEvent {
  const AppStarted();
}

/// Event fired when the validation of the ticket code happened with success
class ValidationSucceeded extends AuthenticationEvent {
  const ValidationSucceeded();
}
