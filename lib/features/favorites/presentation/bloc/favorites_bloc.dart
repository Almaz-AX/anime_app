// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:anime_app/features/favorites/domain/usecases/listenFavoriteTitles.dart';

import '../../../../core/data/local/entity/favorite_title.dart';
import '../../../../core/data/models/anime_title.dart';
import '../../domain/usecases/getFavoriteTitles.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  late final StreamSubscription<List<FavoriteTitle>> subscription;
  final ListenFavoriteTitles listenFavoriteTitles;
  final GetFavoriteTitles getFavoriteTitles;

  FavoritesBloc({
    required this.listenFavoriteTitles,
    required this.getFavoriteTitles,
  }) : super(const FavoritesState(status: Status.loading)) {
    on<FavoritesChangedEvent>(_onListenFavorites);
    on<FavoritesGetEvent>(_onGetFavoritesEvent);
  }

  void _onListenFavorites(
      FavoritesChangedEvent event, Emitter<FavoritesState> emit) {
    subscription = listenFavoriteTitles(NoParams()).listen((event) async {
      if (event.isEmpty) {
        emit(state.copyWith(favoriteTitles: <AnimeTitle>[]));
        return;
      }
      if (state.favoriteTitles.isEmpty) {
        final newTitlesId = <int>[];
        for (var element in event) {
          newTitlesId.add(element.animeTitleId);
        }
        add(FavoritesGetEvent(titlesId: newTitlesId));
        return;
      }
      final stateId = state.favoriteTitles.map((e) => e.id).toSet();
      final eventId = event.map((e) => e.animeTitleId).toSet();
      if (eventId.length > stateId.length) {
        final addedTitleId = eventId.difference(stateId).first;
        add(FavoritesGetEvent(titlesId: [addedTitleId]));
        return;
      }
      final revomedTitleId = stateId.difference(eventId).first;
      final titles = state.favoriteTitles;
      titles.removeWhere((element) => element.id == revomedTitleId);
      emit(state.copyWith(favoriteTitles: titles));
    });
  }

  Future<void> _onGetFavoritesEvent(
      FavoritesGetEvent event, Emitter<FavoritesState> emit) async {
    final responseOrFailure =
        await getFavoriteTitles(Params(titlesId: event.titlesId));
    responseOrFailure.fold(
        (failure) => emit(state.copyWith(
              status: Status.failure,
            )),
        (titles) => emit(state.copyWith(
            status: Status.loaded,
            favoriteTitles: [...state.favoriteTitles, ...titles])));
  }

  @override
  Future<void> close() async {
    subscription.cancel();
    await super.close();
  }
}
