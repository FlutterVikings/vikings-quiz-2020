import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';
import 'package:vikings_quiz/configurations.dart';

/// Fetches the game scores from Firestore
class FirebaseLeaderboardRepository extends LeaderboardRepository {
  /// Timeout for HTTP calls
  final Duration httpTimeout;
  final List<Score> _cache;
  FirebaseLeaderboardRepository(
      {this.httpTimeout = ConfigurationValues.httpTimeout})
      : _cache = [];

  @override
  Future<List<Score>> getData(
      {String filter = "", bool clearCache = false}) async {
    // If the cache is cleared, data are retrieved from Firestore again
    if (clearCache) {
      _cache.clear();
    }

    try {
      if (_cache.isEmpty) {
        var index = 1;

        final documents = await FirebaseFirestore.instance
            .collection("tickets")
            .orderBy("correct_answers", descending: true)
            .orderBy("seconds_left", descending: true)
            .orderBy("submit_date")
            .get()
            .timeout(httpTimeout);

        final data = documents.docs
            .map((data) => Score.fromFirestore(data, index++))
            .toList();

        _cache..addAll(data);
      }

      // Filter the results in case there were a filter
      if (filter.isEmpty) {
        return _cache;
      } else {
        return _cache.where((score) => score.tickedId == filter).toList();
      }
    } on Exception catch (_) {
      return const [];
    }
  }
}
