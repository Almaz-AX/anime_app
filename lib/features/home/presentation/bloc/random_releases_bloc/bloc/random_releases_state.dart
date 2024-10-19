part of 'random_releases_bloc.dart';

sealed class RandomReleasesState extends Equatable {
  const RandomReleasesState();

  @override
  List<Object> get props => [];
}

final class RandomReleasesInitial extends RandomReleasesState {}

final class RandomReleasesLoaded extends RandomReleasesState {
  final List<Release> randomReleases;
  final List<ShikimoriAnime?> releasesScore;

  const RandomReleasesLoaded(
      {required this.randomReleases,
      this.releasesScore = const <ShikimoriAnime>[]});

    @override
  List<Object> get props => [randomReleases, releasesScore];
}
