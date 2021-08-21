import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';

/// Fetches the game scores from a fake data source (use this as mock for tests)
class FakeLeaderboardRepository extends LeaderboardRepository {
  /// The fake list of data to be returned by [getData]
  final List<Score> fakeData;
  const FakeLeaderboardRepository(this.fakeData);

  @override
  Future<List<Score>> getData(
      {String filter = "", bool clearCache = false}) async {
    if (filter.isEmpty) {
      return fakeData;
    } else {
      return fakeData.where((score) => score.tickedId == filter).toList();
    }
  }
}
