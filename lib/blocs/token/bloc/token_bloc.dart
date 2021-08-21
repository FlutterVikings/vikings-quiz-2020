import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:vikings_quiz/blocs/token/model/token_repository.dart';

/// Bloc that manages the simple state of a string, which is the token ID of the
/// player
class TokenBloc extends Bloc<String, String> {
  /// Handles the quiz tokens
  final TokenRepository tokenRepository;
  TokenBloc({@required this.tokenRepository}) : super(tokenRepository.token);

  @override
  Stream<String> mapEventToState(String event) async* {
    // Storing the token
    tokenRepository.token = event;

    yield tokenRepository.token;
  }
}
