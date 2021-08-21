import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/token/token.dart';

void main() {
  TokenBloc tokenBloc;

  setUp(() {
    tokenBloc = TokenBloc(tokenRepository: TitoTokenRepository());
  });

  group("TokenBloc", () {
    test("The initial state must be an empty string", () {
      expect(tokenBloc.state, "");
    });

    test("Testing event and states", () {
      expect("tokenA", "tokenA");
      expect("tokenA", isNot("token"));
    });

    blocTest<TokenBloc, String>("Testing the Bloc with a valid token",
        build: () => tokenBloc,
        act: (bloc) => bloc..add("a")..add("ab")..add("abc"),
        expect: const ["a", "ab", "abc"]);

    blocTest<TokenBloc, String>(
        "Testing the Bloc with an invalid token in the middle",
        build: () => tokenBloc,
        act: (bloc) => bloc..add("a")..add("ab")..add("")..add("abcd"),
        expect: const ["a", "ab", "abcd"]);

    blocTest<TokenBloc, String>(
        "Testing the Bloc with an invalid token in the middle",
        build: () => tokenBloc,
        act: (bloc) => bloc..add("")..add("")..add(""),
        expect: const [""]);
  });
}
