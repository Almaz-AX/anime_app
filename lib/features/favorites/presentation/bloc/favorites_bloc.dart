import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/local/entity/favorite_title.dart';
import '../../../../core/data/models/release.dart';
import '../../domain/usecases/getFavoriteTitles.dart';
import '../../domain/usecases/listenFavoriteTitles.dart';

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
    on<FavoritesRemoveEvent>(_onRemoveFavoritesEvent);
  }

  void _onListenFavorites(
      FavoritesChangedEvent event, Emitter<FavoritesState> emit) {
    subscription = listenFavoriteTitles(NoParams()).listen((event) async {
      if (event.isEmpty) {
        add(FavoritesRemoveEvent(removeTitles: state.favoriteReleases.toSet()));
        return;
      }
      if (state.favoriteReleases.isEmpty) {
        final newTitlesId = <int>[];
        for (var element in event) {
          newTitlesId.add(element.releaseId);
        }
        add(FavoritesGetEvent(titlesId: newTitlesId));
        return;
      }
      final stateId = state.favoriteReleases.map((e) => e.id).toSet();
      final eventId = event.map((e) => e.releaseId).toSet();
      if (eventId.length > stateId.length) {
        final addedTitleId = eventId.difference(stateId).first;
        add(FavoritesGetEvent(titlesId: [addedTitleId]));
        return;
      }
      final revomedTitleId = stateId.difference(eventId).first;
      final titles = state.favoriteReleases;
      final removedTitles =
          titles.where((element) => element.id == revomedTitleId).toSet();
      add(FavoritesRemoveEvent(removeTitles: removedTitles));
    });
  }

  Future<void> _onGetFavoritesEvent(
      FavoritesGetEvent event, Emitter<FavoritesState> emit) async {
    final responseOrFailure =
        await getFavoriteTitles(Params(releasesId: event.titlesId));
    responseOrFailure.fold(
        (failure) => emit(state.copyWith(
              status: Status.failure,
            )),
        (titles) => emit(state.copyWith(
            status: Status.loaded,
            favoriteTitles: [...state.favoriteReleases, ...titles])));
  }

  Future<void> _onRemoveFavoritesEvent(
      FavoritesRemoveEvent event, Emitter<FavoritesState> emit) async {
    final titles = state.favoriteReleases.toSet();
    final dif = titles.difference(event.removeTitles);
    emit(state.copyWith(status: Status.loaded, favoriteTitles: dif.toList()));
  }

  @override
  Future<void> close() async {
    subscription.cancel();
    await super.close();
  }
}
