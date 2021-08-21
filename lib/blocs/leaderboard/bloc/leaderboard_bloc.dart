import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikings_quiz/blocs/leaderboard/leaderboard.dart';

/// This Bloc handles a list of results that can eventually be filtered. The data
/// returned by the list are of type [Score].
class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  /// The repository from which the scores will be fetched
  final LeaderboardRepository repository;
  LeaderboardBloc({@required this.repository})
      : super(const LeaderboardLoading());

  @override
  Stream<LeaderboardState> mapEventToState(LeaderboardEvent event) async* {
    yield const LeaderboardLoading();

    try {
      final list = await repository.getData(
          filter: event.filterString, clearCache: event.clearCache);
      yield LeaderboardLoaded(list);
    } on Exception {
      yield const LeaderboardError();
    }
  }
}
