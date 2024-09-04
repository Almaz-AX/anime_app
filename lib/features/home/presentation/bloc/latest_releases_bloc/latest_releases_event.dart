// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'latest_releases_bloc.dart';

sealed class LatestReleasesEvent extends Equatable {
  const LatestReleasesEvent();

  @override
  List<Object> get props => [];
}

final class LatestReleasesGetEvent extends LatestReleasesEvent {
 
  const LatestReleasesGetEvent();
  @override
  List<Object> get props => [];
}
