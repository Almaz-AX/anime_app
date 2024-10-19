// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'latest_releases_bloc.dart';

sealed class LastReleasesState extends Equatable {
  const LastReleasesState();

  @override
  List<Object> get props => [];
}

final class LastReleasesInitial extends LastReleasesState {}

final class LastReleasesSuccess extends LastReleasesState {
  final List<Release> releases;
  final List<ShikimoriAnime?> releasesScore;
  const LastReleasesSuccess({
    required this.releases,
    this.releasesScore = const <ShikimoriAnime>[],
  });
  @override
  List<Object> get props => [
        releases,
        releasesScore
      ];
}

final class LastReleasesFailure extends LastReleasesState {
  final Failure failure;
  const LastReleasesFailure({
    required this.failure,
  });
}
