import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/authentication/authentication.dart';

/// Mock of the [AuthenticationBloc] bloc
class MockAuthBloc extends MockBloc<AuthenticationBloc>
    implements AuthenticationBloc {}

void main() {
  AuthenticationBloc authenticationBloc;

  setUp(() {
    authenticationBloc = AuthenticationBloc(performStartupInit: false);
  });

  group("AuthenticationBloc", () {
    test("The initial state must be 'AuthenticationDoneLoading'", () {
      expect(authenticationBloc.state, const AuthenticationDoneLoading());
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
        "Testing the behavior on app startup",
        build: () => authenticationBloc,
        act: (bloc) => bloc.add(const AppStarted()),
        expect: const [AuthenticationLoading(), AuthenticationDoneLoading()]);

    blocTest<AuthenticationBloc, AuthenticationState>(
        "Testing the behavior on successful validation",
        build: () => authenticationBloc,
        act: (bloc) => bloc.add(const ValidationSucceeded()),
        expect: const [AuthenticationSucceeded(), AuthenticationDoneLoading()]);
  });
}
