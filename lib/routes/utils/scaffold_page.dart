import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/leaderboard/bloc/leaderboard_bloc.dart';
import 'package:vikings_quiz/blocs/leaderboard/bloc/leaderboard_event.dart';
import 'package:vikings_quiz/blocs/theme/theme.dart';
import 'package:vikings_quiz/routes.dart';

/// The scaffold to be used in the app to create the UI of the pages
class VikingScaffold extends StatelessWidget {
  /// The body of the page
  final Widget body;

  /// The title of the page
  final String title;

  /// The key of the widget
  final Key key;

  /// The FAB, which is disabled by default
  final FloatingActionButton floatingActionButton;

  /// Whether the leading icon should appear or not
  final bool leadingIcon;
  const VikingScaffold(
      {@required this.body,
      this.title = "Vikings Quiz",
      this.leadingIcon = true,
      this.floatingActionButton,
      this.key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          key: Key("viking_appbar_title"),
          style: const TextStyle(fontSize: 28, fontFamily: 'GrenzeGotisch'),
        ),
        centerTitle: true,
        elevation: 15,
        leading: leadingIcon ? const _LeaderboardButton() : null,
        actions: const [_ActionButton()],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
      ),
      body: Stack(
        children: [
          // The background image
          const PageBackground(),

          // The content itself of the page
          body
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

/// A button that opens the leaderboards
class _LeaderboardButton extends StatelessWidget {
  const _LeaderboardButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key("viking_scaffold_leaderboard_button"),
      icon: const Icon(Icons.assessment_rounded),
      onPressed: () {
        context
            .read<LeaderboardBloc>()
            .add(const LeaderboardEvent(clearCache: true));

        Navigator.of(context).pushNamed(RouteGenerator.leaderboardPage);
      },
    );
  }
}

/// A button that changes the theme
class _ActionButton extends StatelessWidget {
  const _ActionButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is LightTheme) {
          return IconButton(
            key: Key("viking_scaffold_dark_button"),
            icon: const Icon(Icons.nightlight_round),
            onPressed: () => context.read<ThemeBloc>().add(const LightEvent()),
          );
        }

        return IconButton(
          key: Key("viking_scaffold_light_button"),
          icon: const Icon(Icons.wb_sunny),
          onPressed: () => context.read<ThemeBloc>().add(const DarkEvent()),
        );
      },
    );
  }
}

/// The background of the page, which changes according with the selected theme
class PageBackground extends StatelessWidget {
  const PageBackground();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      var asset = "assets/town_day.png";

      if (state is DarkTheme) {
        asset = "assets/town_night.png";
      }

      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
        ),
      );
    });
  }
}
