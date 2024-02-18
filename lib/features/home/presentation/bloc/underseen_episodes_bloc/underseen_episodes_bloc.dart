import 'dart:async';

import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/features/home/domain/usecases/get_underseen_episodes.dart';
import 'package:anime_app/features/home/domain/usecases/get_underseen_titles.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/local/entity/watched_episode.dart';
import '../../../domain/usecases/complete_watching.dart';

part 'underseen_episodes_event.dart';
part 'underseen_episodes_state.dart';

class UnderseenEpisodesBloc
    extends Bloc<UnderseenEpisodesEvent, UnderseenEpisodesState> {
  final GetUnderseenEpisodes getUnderseenEpisodes;
  final GetUnderseenTitles getUnderseenTitles;
  final CompleteWatching completeWatching;
  StreamSubscription<List<WatchedEpisode>>? underseenEpisodesSubcription;
  UnderseenEpisodesBloc(
      {required this.getUnderseenEpisodes,
      required this.getUnderseenTitles,
      required this.completeWatching})
      : super(const UnderseenEpisodesState(
            status: UnderseenEpisodesStatus.initial)) {
    on<UnderseenEpisodesGetEvent>(_onGetUnderseenEpisodes);
    on<UnderSeenTitlesGetEvent>(_onGetUnderseenTitles);
    on<UnderSeenTitlesCompleteEvent>(_onCompleteWatching);
  }

  void _onGetUnderseenEpisodes(UnderseenEpisodesGetEvent event, emit) {
    final streamUnderseendEpisodes = getUnderseenEpisodes(NoParams());
    underseenEpisodesSubcription?.cancel();
    underseenEpisodesSubcription = streamUnderseendEpisodes.listen((event) {
      add(UnderSeenTitlesGetEvent(underseenEpisodes: event));
    });
  }

  Future<void> _onGetUnderseenTitles(
      UnderSeenTitlesGetEvent event, emit) async {
    if (event.underseenEpisodes
        .map((e) => e.animeTitleId)
        .toSet()
        .difference(state.underseenEpisodes.map((e) => e.animeTitleId).toSet())
        .isEmpty) {
      emit(state.copyWith(
          underseenEpisodes: event.underseenEpisodes,
          status: UnderseenEpisodesStatus.success));
      return;
    }

    final titleId = event.underseenEpisodes.map((e) => e.animeTitleId).toList();
    final underseendTitlesOrFailure =
        await getUnderseenTitles(Params(titlesId: titleId.toSet().toList()));
    underseendTitlesOrFailure.fold(
        (failure) =>
            emit(state.copyWith(status: UnderseenEpisodesStatus.failure)),
        (titles) {
      if (titles.isEmpty) {
        emit(state.copyWith(
            status: UnderseenEpisodesStatus.initial,
            underseenEpisodes: event.underseenEpisodes,
            underseenTitles: titles));
      } else {
        emit(state.copyWith(
            status: UnderseenEpisodesStatus.success,
            underseenEpisodes: event.underseenEpisodes,
            underseenTitles: titles));
      }
    });
  }

  Future<void> _onCompleteWatching(
      UnderSeenTitlesCompleteEvent event, emit) async {
    await completeWatching(EpisodeParams(episode: event.episode));
  }

  @override
  Future<void> close() {
    underseenEpisodesSubcription?.cancel();
    return super.close();
  }
}
