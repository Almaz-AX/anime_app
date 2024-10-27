import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:anime_app/core/data/models/shikimori_anime.dart';
import 'package:anime_app/core/domain/usecases/get_shikimori_score.dart';

import '../../../../core/data/models/release.dart';
import '../../domain/usecases/add_favorite_title.dart';
import '../../domain/usecases/get_favorite_title.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_stream_watched_episodes.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../domain/usecases/get_title.dart';
import '../../domain/usecases/remove_favorite_title.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetTitle getTitle;
  final GetStreamWatchedEpisodes getWatchedEpisodes;
  final GetFavoriteTitle getFavoriteTitle;
  final RemoveFavoriteTitle removeFavoriteTitle;
  final AddFavoriteTitle addFavoriteTitle;
  final GetShikimoriScore getScore;
  StreamSubscription<List<WatchedEpisode>>? subcription;

  DetailBloc(
      {required this.getTitle,
      required this.getWatchedEpisodes,
      required this.getFavoriteTitle,
      required this.addFavoriteTitle,
      required this.removeFavoriteTitle,
      required this.getScore})
      : super(const DetailState(status: Status.initial)) {
    on<DetailGetTitleEvent>(_onGetTitle);
    on<DetailGetWatchedEpisodesEvent>(_onGetWachedEpisodes);
    on<DetailChangeFavoriteTitleEvent>(_onChangeFavoriteTitleEvent);
    on<DetailGetScoreEvent>(_onGetScoreEvent);
  }

  Future<void> _onGetTitle(
      DetailGetTitleEvent event, Emitter<DetailState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final failureOrTitle = await getTitle(Params(id: event.id));
    final failureOrFavorite = await getFavoriteTitle(Params(id: event.id));
    bool isFavorite = failureOrFavorite.fold((l) => false, (favoriteTitle) {
      if (favoriteTitle?.releaseId == event.id) {
        return true;
      }
      return false;
    });
    failureOrTitle.fold(
        (failure) => emit(state.copyWith(
            status: Status.failure,
            message: 'Что то пошло не так')), (release) async {
      emit(state.copyWith(
        status: Status.loaded,
        release: release,
        isFavorite: isFavorite,
      ));

      final stream = getWatchedEpisodes(Params(id: event.id));
      subcription?.cancel();
      subcription = stream.listen((event) {
        add(DetailGetWatchedEpisodesEvent(watchedEpisodes: event));
      });
      add(DetailGetScoreEvent(release: release));
    });
  }

  void _onGetWachedEpisodes(
      DetailGetWatchedEpisodesEvent event, Emitter<DetailState> emit) {
    emit(state.copyWith(watchedEpisodes: event.watchedEpisodes));
  }

  Future<void> _onChangeFavoriteTitleEvent(
      DetailChangeFavoriteTitleEvent event, Emitter<DetailState> emit) async {
    if (state.isFavorite) {
      await removeFavoriteTitle(Params(id: event.id));
      emit(state.copyWith(isFavorite: false));
    } else {
      await addFavoriteTitle(Params(id: event.id));
      emit(state.copyWith(isFavorite: true));
    }
  }

  Future<void> _onGetScoreEvent(
      DetailGetScoreEvent event, Emitter<DetailState> emit) async {
    final scoreOrFailure = await getScore(
        ShikimoriParams(releaseName: event.release.name.english));
    scoreOrFailure.fold((failure) => null,
        (scoreList) => emit(state.copyWith(score: scoreList.firstOrNull)));
  }

  @override
  Future<void> close() async {
    await subcription?.cancel();
    return super.close();
  }
}
