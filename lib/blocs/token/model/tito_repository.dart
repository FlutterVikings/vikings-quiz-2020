import 'package:vikings_quiz/blocs/token/model/token_repository.dart';

/// Repository for tokens managed by the Tito system
class TitoTokenRepository implements TokenRepository {
  var _token = "";

  TitoTokenRepository({String tokenId = ""}) : _token = tokenId;

  @override
  String get token => _token;

  @override
  void set token(String value) {
    // Tito tokens can't be empty
    if (value.length > 0) {
      _token = value;
    }
  }
}
