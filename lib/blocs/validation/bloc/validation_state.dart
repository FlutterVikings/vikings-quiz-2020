import 'package:equatable/equatable.dart';
import 'validation_bloc.dart';

/// States for the [ValidationBloc] bloc
abstract class ValidationState extends Equatable {
  const ValidationState();

  @override
  List<Object> get props => [];
}

/// Initial state of the validation process
class ValidationNone extends ValidationState {
  const ValidationNone();
}

/// The token validation is happening in the background so the user has to wait
class ValidationLoading extends ValidationState {
  const ValidationLoading();
}

/// Something in the validation process failed
class ValidationFailed extends ValidationState {
  /// The reason why the validation failed
  final String reason;
  const ValidationFailed(this.reason);

  @override
  List<Object> get props => [reason];
}
