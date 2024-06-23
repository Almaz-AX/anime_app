// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_bloc.dart';

class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesChangedEvent extends FavoritesEvent {}

class FavoritesGetEvent extends FavoritesEvent {
  final List<int> titlesId;
  const FavoritesGetEvent({
    required this.titlesId,
  });
}

class FavoritesRemoveEvent extends FavoritesEvent {
  final Set<AnimeTitle> removeTitles;
  const FavoritesRemoveEvent({
    required this.removeTitles,
  });
}
