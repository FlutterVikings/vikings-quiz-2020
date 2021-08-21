import 'package:equatable/equatable.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';

/// Event for the [LeaderboardBloc] bloc
class LeaderboardEvent extends Equatable {
  /// The stirng to be used to filter the list
  final String filterString;

  /// Tells whether the internal cache has to be cleared or not
  final bool clearCache;
  const LeaderboardEvent({
    this.filterString = "",
    this.clearCache = false,
  });

  @override
  List<Object> get props => [filterString, clearCache];
}
