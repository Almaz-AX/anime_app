// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'latest_releases_bloc.dart';

sealed class LatestReleasesState extends Equatable {
  const LatestReleasesState();

  @override
  List<Object> get props => [];
}

final class LastUpdatesInitial extends LatestReleasesState {}

final class LastUpdatesSuccessState extends LatestReleasesState {
  final List<Release> releases;
  const LastUpdatesSuccessState({
    required this.releases,
  });
  @override
  List<Object> get props => [ releases,];

  LastUpdatesSuccessState copyWith({
    List<Release>? releases,
  }) {
    return LastUpdatesSuccessState(
      releases: releases ?? this.releases,
    );
  }
}

final class LastUpdatesFailureState extends LatestReleasesState {
  final Failure failure;
  const LastUpdatesFailureState({
    required this.failure,
  });
}
