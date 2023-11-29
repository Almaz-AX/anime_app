import 'dart:async';

import 'package:anime_app/core/data/local/DAO/watched_episode_dao.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../injection_container.dart';
import '../../domain/usecases/get_watched_episodes.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/data/models/anime_title.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_title.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetTitle getTitle;
  final GetWatchedEpisodes getWatchedEpisodes;
  StreamSubscription<List<WatchedEpisode>>? subcription;
  final WatchedEpisodesDAO dao = sl();

  DetailBloc({
    required this.getTitle,
    required this.getWatchedEpisodes,
  }) : super(DetailInitialState()) {
    on<DetailGetTitleEvent>(_onGetTitle);
    on<DetailGetWatchedEpisodesEvent>(_onGetWachedEpisodes);
  }

  Future<void> _onGetTitle(
      DetailGetTitleEvent event, Emitter<DetailState> emit) async {
    emit(DetailLoadingState());
    final failureOrTitle = await getTitle(Params(id: event.id));
    failureOrTitle.fold(
        (failure) =>
            emit(DetailErrorState(message: _mapFailureToMessage(failure))),
        (title) async {
      emit(DetailLoadedState(
        title: title,
      ));
      final stream = getWatchedEpisodes(Params(id: event.id));
      subcription?.cancel();
      subcription = stream.listen((event) async {
        add(DetailGetWatchedEpisodesEvent(
            title: title, watchedEpisodes: event));
      });
    });
  }

  void _onGetWachedEpisodes(
      DetailGetWatchedEpisodesEvent event, Emitter<DetailState> emit) {
    emit(DetailLoadedState(
        title: event.title, watchedEpisodes: event.watchedEpisodes));
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Что-то с интернетом';
    }
    if (failure is CasheFailure) {
      return 'Ошибка кеша';
    }
    return 'Что то пошло не так';
  }

  @override
  Future<void> close() async {
    print(subcription);
    await subcription?.cancel();
    print(subcription);
    return super.close();
  }
}
