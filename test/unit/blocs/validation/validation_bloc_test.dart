import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/authentication/authentication.dart';
import 'package:vikings_quiz/blocs/validation/validation.dart';

class MockTicketRepository extends Mock implements TicketRepository {}

void main() {
  ValidationBloc validationBloc;
  AuthenticationBloc authenticationBloc;

  setUp(() {
    authenticationBloc = AuthenticationBloc(performStartupInit: false);

    validationBloc = ValidationBloc(
      validationRepository: MockAuthRepository(true),
      authenticationBloc: authenticationBloc,
    );
  });

  group("TokenBloc", () {
    test("The initial state must be 'ValidationNone'", () {
      expect(validationBloc.state, const ValidationNone());
    });

    blocTest<ValidationBloc, ValidationState>(
        "Testing when the authentication succeedes",
        build: () => validationBloc,
        act: (bloc) => bloc..add(const ValidationEvent(token: "abc")),
        expect: const [
          ValidationLoading(),
          ValidationNone(),
        ],
        verify: (bloc) {
          expect(authenticationBloc.state, const AuthenticationDoneLoading());
        });

    blocTest<ValidationBloc, ValidationState>(
        "Testing when the authentication fails",
        build: () => ValidationBloc(
              validationRepository: MockAuthRepository(false),
              authenticationBloc: authenticationBloc,
            ),
        act: (bloc) => bloc..add(const ValidationEvent(token: "abc")),
        expect: const [
          ValidationLoading(),
          ValidationFailed("The validation phase failed."),
          ValidationNone(),
        ],
        verify: (bloc) {
          expect(authenticationBloc.state, const AuthenticationDoneLoading());
        });

    blocTest<ValidationBloc, ValidationState>(
        "Testing the Tito API repository implementation (success request)",
        build: () {
          final TicketRepository ticketRepository = MockTicketRepository();
          when(ticketRepository.validate(token: ""))
              .thenAnswer((_) async => true);

          return ValidationBloc(
            validationRepository: ticketRepository,
            authenticationBloc: authenticationBloc,
          );
        },
        act: (bloc) => bloc..add(const ValidationEvent(token: "")),
        expect: const [
          ValidationLoading(),
          ValidationNone(),
        ],
        verify: (bloc) {
          expect(authenticationBloc.state, const AuthenticationDoneLoading());
        });

    blocTest<ValidationBloc, ValidationState>(
        "Testing the Tito API repository implementation (failed request)",
        build: () {
          final TicketRepository ticketRepository = MockTicketRepository();
          when(ticketRepository.validate(token: ""))
              .thenAnswer((_) async => false);

          return ValidationBloc(
            validationRepository: ticketRepository,
            authenticationBloc: authenticationBloc,
          );
        },
        act: (bloc) => bloc..add(const ValidationEvent(token: "")),
        expect: const [
          ValidationLoading(),
          ValidationFailed("The validation phase failed."),
          ValidationNone(),
        ],
        verify: (bloc) {
          expect(authenticationBloc.state, const AuthenticationDoneLoading());
        });
  });
}
