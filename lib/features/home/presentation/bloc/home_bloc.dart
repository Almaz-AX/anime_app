import 'dart:async';

import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/features/home/domain/usecases/get_underseen_episodes.dart';
import 'package:anime_app/features/home/domain/usecases/get_underseen_titles.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../domain/usecases/complete_watching.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUnderseenEpisodes getUnderseenEpisodes;
  final GetUnderseenTitles getUnderseenTitles;
  final CompleteWatching completeWatching;
  StreamSubscription<List<WatchedEpisode>>? underseenEpisodesSubcription;
  HomeBloc(
      {required this.getUnderseenEpisodes,
      required this.getUnderseenTitles,
      required this.completeWatching})
      : super(HomeState(status: HomeStatus.loading)) {
    on<HomeGetUnderSeenEpisodesEvent>(_onGetUnderseenEpisodes);
    on<HomeGetUnderSeenTitlesEvent>(_onGetUnderseenTitles);
    on<HomeCompleteWatchingEvent>(_onCompleteWatching);
  }

  void _onGetUnderseenEpisodes(HomeGetUnderSeenEpisodesEvent event, emit) {
    final streamUnderseendEpisodes = getUnderseenEpisodes(NoParams());
    underseenEpisodesSubcription?.cancel();
    underseenEpisodesSubcription = streamUnderseendEpisodes.listen((event) {
      add(HomeGetUnderSeenTitlesEvent(underseenEpisodes: event));
    });
  }

  Future<void> _onGetUnderseenTitles(
      HomeGetUnderSeenTitlesEvent event, emit) async {
    if (event.underseenEpisodes
        .map((e) => e.animeTitleId)
        .toSet()
        .difference(state.underseenEpisodes.map((e) => e.animeTitleId).toSet())
        .isEmpty) {
      emit(state.copyWith(
          underseenEpisodes: event.underseenEpisodes,
          status: HomeStatus.success));
      return;
    }

    final titleId = event.underseenEpisodes.map((e) => e.animeTitleId).toList();
    final underseendTitlesOrFailure =
        await getUnderseenTitles(Params(titlesId: titleId.toSet().toList()));
    underseendTitlesOrFailure
        .fold((failure) => emit(state.copyWith(status: HomeStatus.failure)),
            (titles) {
      if (titles.isEmpty) {
        emit(state.copyWith(
            status: HomeStatus.initial,
            underseenEpisodes: event.underseenEpisodes,
            underseenTitles: titles));
      } else {
        emit(state.copyWith(
            status: HomeStatus.success,
            underseenEpisodes: event.underseenEpisodes,
            underseenTitles: titles));
      }
    });
  }

  Future<void> _onCompleteWatching(
      HomeCompleteWatchingEvent event, emit) async {
    await completeWatching(EpisodeParams(episode: event.episode));
  }

  @override
  Future<void> close() {
    underseenEpisodesSubcription?.cancel();
    return super.close();
  }
}
