// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'underseen_episodes_bloc.dart';

enum UnderseenEpisodesStatus { initial, success, failure }

class UnderseenEpisodesState extends Equatable {
  final UnderseenEpisodesStatus status;
  final List<WatchedEpisode> underseenEpisodes;
  final List<Release> underseenReleases;
  const UnderseenEpisodesState({
    required this.status,
    this.underseenEpisodes = const <WatchedEpisode>[],
    this.underseenReleases = const <Release>[],
  });

  @override
  List<Object> get props => [status, underseenEpisodes, underseenReleases];

  UnderseenEpisodesState copyWith({
    UnderseenEpisodesStatus? status,
    List<WatchedEpisode>? underseenEpisodes,
    List<Release>? underseenReleases,
  }) {
    return UnderseenEpisodesState(
      status: status ?? this.status,
      underseenEpisodes: underseenEpisodes ?? this.underseenEpisodes,
      underseenReleases: underseenReleases ?? this.underseenReleases,
    );
  }
}
