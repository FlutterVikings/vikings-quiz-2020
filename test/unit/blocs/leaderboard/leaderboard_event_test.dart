import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';

void main() {
  group("LeaderboardEvent tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(const LeaderboardEvent(), const LeaderboardEvent());

      expect(const LeaderboardEvent(clearCache: false),
          const LeaderboardEvent(clearCache: false));
      expect(const LeaderboardEvent(clearCache: false, filterString: ""),
          const LeaderboardEvent(clearCache: false, filterString: ""));

      expect(const LeaderboardEvent(clearCache: false, filterString: ""),
          isNot(const LeaderboardEvent(clearCache: true, filterString: "")));
      expect(const LeaderboardEvent(clearCache: false, filterString: ""),
          isNot(const LeaderboardEvent(clearCache: false, filterString: "_")));
    });
  });
}
