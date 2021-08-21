import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/token/token.dart';

void main() {
  group("Tests for the TitoTokenRepository token validation repository", () {
    test("The initial state must be an empty token", () {
      final repo = TitoTokenRepository();
      expect(repo.token, "");
    });

    test("Adding a valid token", () {
      final repo = TitoTokenRepository()..token = "test";

      expect(repo.token, "test");
    });

    test("Adding an invalid token", () {
      final repo = TitoTokenRepository()..token = "";

      expect(repo.token, "");
    });

    test("Adding a valid and then an invalid token", () {
      // Valid token addition
      final repo = TitoTokenRepository()..token = "abc";
      expect(repo.token, "abc");

      // Invalid token addition
      repo.token = "";
      expect(repo.token, "abc");
    });
  });
}
