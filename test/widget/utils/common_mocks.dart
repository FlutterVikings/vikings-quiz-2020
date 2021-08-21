import 'package:bloc_test/bloc_test.dart';
import 'package:vikings_quiz/blocs/authentication/authentication.dart';
import 'package:vikings_quiz/blocs/countdown/countdown.dart';
import 'package:vikings_quiz/blocs/quiz/bloc/quiz_bloc.dart';
import 'package:vikings_quiz/blocs/theme/theme.dart';
import 'package:vikings_quiz/blocs/token/bloc/token_bloc.dart';
import 'package:vikings_quiz/blocs/validation/validation.dart';

import '../bloc_mocks.dart';

/// Mock of the [ThemeBloc] bloc
class MockThemeBloc extends MockBloc<ThemeBloc> implements ThemeBloc {}

/// Mock of the [AuthenticationBloc] bloc
class MockAuthBloc extends MockBloc<AuthenticationBloc>
    implements AuthenticationBloc {}

/// Mock of the [ValidationBloc] bloc
class MockValidationBloc extends MockBloc<ValidationBloc>
    implements ValidationBloc {}

/// Mock of the [TokenBloc] bloc
class MockTokenBloc extends MockBloc<TokenBloc> implements TokenBloc {}

/// Mock of the [CountdownBloc] bloc
class MockCountdownBloc extends MockBloc<CountdownBloc>
    implements CountdownBloc {}

/// Mock of the [QuizBloc] bloc
class MockQuizBloc extends MockBloc<QuizBloc> implements QuizBloc {}

/// Mock of the [LeaderboardBloc] bloc
class MockLeaderboardBloc extends MockBloc<LeaderboardBloc>
    implements LeaderboardBloc {}
