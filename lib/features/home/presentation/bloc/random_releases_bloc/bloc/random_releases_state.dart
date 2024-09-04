part of 'random_releases_bloc.dart';

sealed class RandomReleasesState extends Equatable {
  const RandomReleasesState();

  @override
  List<Object> get props => [];
}

final class RandomTitlesInitial extends RandomReleasesState {}

final class RandomTitlesLoaded extends RandomReleasesState {
  final List<Release> randomReleases;

  const RandomTitlesLoaded({required this.randomReleases});
}
