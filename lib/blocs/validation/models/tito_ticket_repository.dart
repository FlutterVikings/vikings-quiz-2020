import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vikings_quiz/configurations.dart';

import 'validation_repository.dart';

/// Validates an user according with its ticket ID using the Tito API
/// (https://api.tito.io/v3)
class TicketRepository extends ValidationRepository {
  const TicketRepository();

  /// HTTP dio client
  static final _client = Dio(BaseOptions(
    baseUrl: "https://api.tito.io/v3/flutter-vikings/online20/tickets/",
    connectTimeout: 4000, // 4 seconds
    receiveTimeout: 4000, // 4 seconds
    headers: <String, String>{
      "Authorization": "Token token=${ConfigurationValues.titoSecret}",
      "Accept": "application/json"
    },
  ));

  @override
  Future<bool> validate({@required String token}) async {
    try {
      final response = await _client.get<String>(token);
      return response.statusCode == 200;
    } on Exception catch (_) {
      return false;
    }
  }
}
