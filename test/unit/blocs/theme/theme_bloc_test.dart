import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:vikings_quiz/blocs/theme/theme.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  ThemeBloc themeBloc;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mocking the storage
    var storage = MockStorage();
    HydratedBloc.storage = storage;

    // Stub
    when(storage.write(any, any)).thenAnswer((_) async {});
    themeBloc = ThemeBloc();
  });

  group("ThemeBloc", () {
    test("The initial state must be 'null' because no storage is present", () {
      expect(themeBloc.state, LightTheme());
    });

    blocTest<ThemeBloc, ThemeState>("Testing a sequence of theme changes",
        build: () => themeBloc,
        act: (bloc) => bloc
          ..add(const DarkEvent())
          ..add(const DarkEvent())
          ..add(const LightEvent())
          ..add(const DarkEvent())
          ..add(const LightEvent()),
        expect: [
          LightTheme(),
          DarkTheme(),
          LightTheme(),
          DarkTheme(),
        ]);

    // Should be empty because no states are stored on the "first shot"
    blocTest<ThemeBloc, ThemeState>("Testing the first emitted state",
        build: () => ThemeBloc(), act: (bloc) => bloc, expect: []);
  });
}
