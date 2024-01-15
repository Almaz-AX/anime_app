import 'dart:async';

import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/features/home/domain/usecases/get_underseen_episodes.dart';
import 'package:anime_app/features/home/domain/usecases/get_underseen_titles.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/local/entity/watched_episode.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUnderseenEpisodes getUnderseenEpisodes;
  final GetUnderseenTitles getUnderseenTitles;
  StreamSubscription<List<WatchedEpisode>>? underseenEpisodesSubcription;
  HomeBloc(
      {required this.getUnderseenEpisodes, required this.getUnderseenTitles})
      : super(HomeState(status: HomeStatus.initial)) {
    on<HomeGetUnderSeenEpisodesEvent>(_onGetUnderseenEpisodes);
    on<HomeGetUnderSeenTitlesEvent>(_onGetUnderseenTitles);
  }

  void _onGetUnderseenEpisodes(HomeGetUnderSeenEpisodesEvent event, emit) {
    emit(state.copyWith(status: HomeStatus.loading));
    final streamUnderseendEpisodes = getUnderseenEpisodes(NoParams());
    underseenEpisodesSubcription?.cancel();
    underseenEpisodesSubcription = streamUnderseendEpisodes.listen((event) {
      if (event.isEmpty) {
        return;
      }
      if (event
          .map((e) => e.animeTitleId)
          .toSet()
          .difference(
              state.underseenEpisodes.map((e) => e.animeTitleId).toSet())
          .isEmpty) {
        emit(state.copyWith(underseenEpisodes: event));
        return;
      }
      add(HomeGetUnderSeenTitlesEvent(underseenEpisodes: event));
    });
  }

  Future<void> _onGetUnderseenTitles(
      HomeGetUnderSeenTitlesEvent event, emit) async {
    final titleId = event.underseenEpisodes.map((e) => e.animeTitleId).toList();
    final underseendTitlesOrFailure =
        await getUnderseenTitles(Params(titlesId: titleId.toSet().toList()));
    underseendTitlesOrFailure.fold(
        (failure) => emit(state.copyWith(status: HomeStatus.failure)),
        (titles) => emit(state.copyWith(
            status: HomeStatus.success,
            underseenEpisodes: event.underseenEpisodes,
            underseenTitles: titles)));
  }
}
