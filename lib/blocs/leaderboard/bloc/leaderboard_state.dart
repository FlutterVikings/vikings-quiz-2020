import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';

/// Events for the [LeaderboardBloc] bloc
abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

/// Emitted while the repository is loading the data
class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading();
}

/// Error while loading data
class LeaderboardError extends LeaderboardState {
  const LeaderboardError();
}

/// Error while loading data
class LeaderboardLoaded extends LeaderboardState {
  final List<Score> _scores;
  const LeaderboardLoaded(this._scores);

  /// The global scores of the players
  List<Score> get gameScores => UnmodifiableListView(_scores);

  @override
  List<Object> get props => [_scores];
}
