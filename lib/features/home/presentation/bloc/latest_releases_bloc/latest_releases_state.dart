// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'latest_releases_bloc.dart';

sealed class LatestReleasesState extends Equatable {
  const LatestReleasesState();

  @override
  List<Object> get props => [];
}

final class LastUpdatesInitial extends LatestReleasesState {}

final class LastUpdatesSuccess extends LatestReleasesState {
  final List<Release> releases;
  const LastUpdatesSuccess({
    required this.releases,
  });
  @override
  List<Object> get props => [
        releases,
      ];

  LastUpdatesSuccess copyWith({
    List<Release>? releases,
  }) {
    return LastUpdatesSuccess(
      releases: releases ?? this.releases,
    );
  }
}

final class LastUpdatesFailure extends LatestReleasesState {
  final Failure failure;
  const LastUpdatesFailure({
    required this.failure,
  });
}
