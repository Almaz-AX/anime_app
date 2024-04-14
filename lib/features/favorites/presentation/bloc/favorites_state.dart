// ignore_for_file: public_member_api_docs, sort_constructors_first;

part of 'favorites_bloc.dart';

enum Status {
  initial,
  loading,
  loaded,
  failure,
}

class FavoritesState extends Equatable {
  final Status status;
  final List<AnimeTitle> favoriteTitles;
  const FavoritesState({
    required this.status,
    this.favoriteTitles = const <AnimeTitle>[],
  });

  @override
  List<Object> get props => [status, favoriteTitles];

  FavoritesState copyWith({
    Status? status,
    List<AnimeTitle>? favoriteTitles,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favoriteTitles: favoriteTitles ?? this.favoriteTitles,
    );
  }
}
