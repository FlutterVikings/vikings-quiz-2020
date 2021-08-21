import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'validation_bloc.dart';

/// Event for the [ValidationBloc] bloc
class ValidationEvent extends Equatable {
  /// The user token to be validated
  final String token;
  const ValidationEvent({@required this.token});

  @override
  List<Object> get props => [token];
}
