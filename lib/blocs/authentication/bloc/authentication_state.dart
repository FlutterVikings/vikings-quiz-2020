import 'package:equatable/equatable.dart';
import 'authentication_bloc.dart';

/// States for the [AuthenticationBloc] bloc
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

/// Indicates that the loading phase has finished
class AuthenticationDoneLoading extends AuthenticationState {
  const AuthenticationDoneLoading();
}

/// The authentication is happening in the background so the user has to wait
class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

/// The ticket validation happened with success so the user can proceed to the
/// next page
class AuthenticationSucceeded extends AuthenticationState {
  const AuthenticationSucceeded();
}

/// The app successfully loaded but the user cannot play the quiz
class AuthenticationNoQuiz extends AuthenticationState {
  const AuthenticationNoQuiz();
}
