// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'underseen_episodes_bloc.dart';

enum UnderseenEpisodesStatus { initial, success, failure }

class UnderseenEpisodesState extends Equatable {
  final UnderseenEpisodesStatus status;
  final List<WatchedEpisode> underseenEpisodes;
  final List<AnimeTitle> underseenTitles;
  const UnderseenEpisodesState({
    required this.status,
    this.underseenEpisodes = const <WatchedEpisode>[],
    this.underseenTitles = const <AnimeTitle>[],
  });

  @override
  List<Object> get props => [status, underseenEpisodes, underseenTitles];

  UnderseenEpisodesState copyWith({
    UnderseenEpisodesStatus? status,
    List<WatchedEpisode>? underseenEpisodes,
    List<AnimeTitle>? underseenTitles,
  }) {
    return UnderseenEpisodesState(
      status: status ?? this.status,
      underseenEpisodes: underseenEpisodes ?? this.underseenEpisodes,
      underseenTitles: underseenTitles ?? this.underseenTitles,
    );
  }
}
