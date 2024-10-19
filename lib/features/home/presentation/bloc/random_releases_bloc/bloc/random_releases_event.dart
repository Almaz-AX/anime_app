part of 'random_releases_bloc.dart';

sealed class RandomReleasesEvent extends Equatable {
  const RandomReleasesEvent();

  @override
  List<Object> get props => [];
}

final class RandomReleasesGetEvent extends RandomReleasesEvent {}

final class RandomReleasesScoreGetEvent extends RandomReleasesEvent {
  final List<Release> releases;

  const RandomReleasesScoreGetEvent({required this.releases});
}
