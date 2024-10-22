// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'latest_releases_bloc.dart';

sealed class LastReleasesState extends Equatable {
  const LastReleasesState();

  @override
  List<Object> get props => [];
}

final class LastReleasesInitial extends LastReleasesState {}

final class LastReleasesSuccess extends LastReleasesState {
  final List<ReleaseContainer> releaseContainers;

  const LastReleasesSuccess({
    required this.releaseContainers,
    
  });
  @override
  List<Object> get props => [releaseContainers,];
}

final class LastReleasesFailure extends LastReleasesState {
  final Failure failure;
  const LastReleasesFailure({
    required this.failure,
  });
}


class ReleaseContainer extends Equatable {
  final Release release;
  final ShikimoriAnime? score;
  const ReleaseContainer({
    required this.release,
    this.score,
  });
  
  @override
  List<Object?> get props => [release, score];

  ReleaseContainer copyWith({
    Release? release,
    ShikimoriAnime? score,
  }) {
    return ReleaseContainer(
      release: release ?? this.release,
      score: score ?? this.score,
    );
  }
}
