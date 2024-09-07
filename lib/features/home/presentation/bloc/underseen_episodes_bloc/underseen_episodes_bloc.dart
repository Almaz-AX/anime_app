import 'dart:async';

import 'package:anime_app/features/home/domain/usecases/get_underseen_episodes.dart';
import 'package:anime_app/features/home/domain/usecases/get_underseen_releases.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/local/entity/watched_episode.dart';
import '../../../../../core/data/models/release.dart';
import '../../../domain/usecases/complete_watching.dart';

part 'underseen_episodes_event.dart';
part 'underseen_episodes_state.dart';

class UnderseenEpisodesBloc
    extends Bloc<UnderseenEpisodesEvent, UnderseenEpisodesState> {
  final GetUnderseenEpisodes getUnderseenEpisodes;
  final GetUnderseenReleases getUnderseenTitles;
  final CompleteWatching completeWatching;
  StreamSubscription<List<WatchedEpisode>>? underseenEpisodesSubcription;
  UnderseenEpisodesBloc(
      {required this.getUnderseenEpisodes,
      required this.getUnderseenTitles,
      required this.completeWatching})
      : super(const UnderseenEpisodesState(
            status: UnderseenEpisodesStatus.loading)) {
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
        .map((e) => e.releaseId)
        .toSet()
        .difference(state.underseenEpisodes.map((e) => e.releaseId).toSet())
        .isEmpty) {
      emit(state.copyWith(
          underseenEpisodes: event.underseenEpisodes,
          status: UnderseenEpisodesStatus.success));
      return;
    }

    final titleId = event.underseenEpisodes.map((e) => e.releaseId).toList();
    final underseendTitlesOrFailure =
        await getUnderseenTitles(Params(releasesId: titleId.toSet().toList()));
    underseendTitlesOrFailure.fold(
        (failure) =>
            emit(state.copyWith(status: UnderseenEpisodesStatus.failure)),
        (titles) {
      if (titles.isEmpty) {
        emit(state.copyWith(
            status: UnderseenEpisodesStatus.loading,
            underseenEpisodes: event.underseenEpisodes,
            underseenReleases: titles));
      } else {
        emit(state.copyWith(
            status: UnderseenEpisodesStatus.success,
            underseenEpisodes: event.underseenEpisodes,
            underseenReleases: titles));
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
