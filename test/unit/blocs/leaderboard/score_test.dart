import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';

void main() {
  group("Score tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(
          const Score(
              timeLeft: Duration(seconds: 3),
              correctAnswers: 10,
              position: 1,
              tickedId: "abc"),
          const Score(
              timeLeft: Duration(seconds: 3),
              correctAnswers: 10,
              position: 1,
              tickedId: "abc"));

      expect(
          const Score(
              timeLeft: Duration(seconds: 3),
              correctAnswers: 10,
              position: 1,
              tickedId: "abc"),
          isNot(const Score(
              timeLeft: Duration(seconds: 3),
              correctAnswers: 10,
              position: 1,
              tickedId: "_")));
    });
  });
}
