import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';

void main() {
  group("LeaderboardState tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(const LeaderboardLoading(), const LeaderboardLoading());
      expect(const LeaderboardError(), const LeaderboardError());
      expect(const LeaderboardLoaded([]), const LeaderboardLoaded([]));

      const scores = [
        Score(
            timeLeft: Duration(), tickedId: "", position: 0, correctAnswers: 0)
      ];

      expect(
          const LeaderboardLoaded([]), isNot(const LeaderboardLoaded(scores)));
    });
  });
}
