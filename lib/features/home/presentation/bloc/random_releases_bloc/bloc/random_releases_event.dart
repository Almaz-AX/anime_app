part of 'random_releases_bloc.dart';

sealed class RandomReleasesEvent extends Equatable {
  const RandomReleasesEvent();

  @override
  List<Object> get props => [];
}

final class RandomTitlesGetEvent extends RandomReleasesEvent {}
