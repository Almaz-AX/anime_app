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
  final List<Release> favoriteReleases;
  const FavoritesState({
    required this.status,
    this.favoriteReleases = const <Release>[],
  });

  @override
  List<Object> get props => [status, favoriteReleases];

  FavoritesState copyWith({
    Status? status,
    List<Release>? favoriteTitles,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favoriteReleases: favoriteTitles ?? this.favoriteReleases,
    );
  }
}
