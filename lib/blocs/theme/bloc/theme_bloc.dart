import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:vikings_quiz/blocs/theme/bloc/theme_events.dart';
import 'package:vikings_quiz/blocs/theme/bloc/theme_states.dart';

/// Changes the theme of the app, switching from "Light" to "Dart" and vice versa.
class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightTheme());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is DarkEvent) {
      yield LightTheme();
    }
    if (event is LightEvent) {
      yield DarkTheme();
    }
  }

  @override
  ThemeState fromJson(Map<String, dynamic> source) {
    try {
      if (source['light'] as bool) {
        return LightTheme();
      }

      return DarkTheme();
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Map<String, bool> toJson(ThemeState themeData) {
    try {
      return {'light': state is LightTheme};
    } on Exception catch (_) {
      return null;
    }
  }
}
