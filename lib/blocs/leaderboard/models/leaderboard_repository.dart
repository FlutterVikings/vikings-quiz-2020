import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';

/// Fetches the game scores from a certain data source
abstract class LeaderboardRepository {
  const LeaderboardRepository();

  /// Fetches data from a specific data source. If [filter] is not an empty string,
  /// the results will be altered to match the criteria imposed by [filter].
  ///
  /// In other words, [filter] can be used to implement the "search" feature on
  /// a list.
  Future<List<Score>> getData({String filter = "", bool clearCache = false});
}
