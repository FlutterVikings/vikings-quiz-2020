import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';

class MockRepository extends Mock implements FakeLeaderboardRepository {}

void main() {
  LeaderboardBloc leaderboardBloc;
  List<Score> scores;

  setUp(() {
    scores = const [
      Score(
          timeLeft: Duration(minutes: 8),
          tickedId: "test1",
          position: 1,
          correctAnswers: 15),
      Score(
          timeLeft: Duration(minutes: 7),
          tickedId: "test2",
          position: 2,
          correctAnswers: 15),
      Score(
          timeLeft: Duration(minutes: 9),
          tickedId: "test3",
          position: 3,
          correctAnswers: 13),
    ];

    leaderboardBloc =
        LeaderboardBloc(repository: FakeLeaderboardRepository(scores));
  });

  group("LeaderboardBloc", () {
    test("The initial state must be 'LeaderboardBloc'", () {
      expect(leaderboardBloc.state, const LeaderboardLoading());
    });

    blocTest<LeaderboardBloc, LeaderboardState>(
        "Testing the entire leaderboard list",
        build: () => leaderboardBloc,
        act: (bloc) => bloc.add(const LeaderboardEvent()),
        expect: [
          const LeaderboardLoading(),
          LeaderboardLoaded(const [
            Score(
                timeLeft: Duration(minutes: 8),
                tickedId: "test1",
                position: 1,
                correctAnswers: 15),
            Score(
                timeLeft: Duration(minutes: 7),
                tickedId: "test2",
                position: 2,
                correctAnswers: 15),
            Score(
                timeLeft: Duration(minutes: 9),
                tickedId: "test3",
                position: 3,
                correctAnswers: 13),
          ])
        ],
        verify: (bloc) {
          final state = bloc.state;

          expect(state, isA<LeaderboardLoaded>());
          if (state is LeaderboardLoaded) {
            expect(state.gameScores.length, scores.length);
          }
        });

    blocTest<LeaderboardBloc, LeaderboardState>(
        "Testing the filtered leaderboard list",
        build: () => leaderboardBloc,
        act: (bloc) => bloc.add(const LeaderboardEvent(filterString: "test2")),
        expect: [
          const LeaderboardLoading(),
          LeaderboardLoaded(const [
            Score(
                timeLeft: Duration(minutes: 7),
                tickedId: "test2",
                position: 2,
                correctAnswers: 15)
          ])
        ],
        verify: (bloc) {
          final state = bloc.state;

          expect(state, isA<LeaderboardLoaded>());
          if (state is LeaderboardLoaded) {
            expect(state.gameScores.length, 1);
          }
        });

    blocTest<LeaderboardBloc, LeaderboardState>(
        "Making sure exceptions are handled",
        build: () {
          final FakeLeaderboardRepository repo = MockRepository();
          when(repo.getData()).thenThrow(Exception("Whoops"));

          return LeaderboardBloc(repository: repo);
        },
        act: (bloc) => bloc.add(const LeaderboardEvent()),
        expect: const [LeaderboardLoading(), LeaderboardError()]);
  });
}
