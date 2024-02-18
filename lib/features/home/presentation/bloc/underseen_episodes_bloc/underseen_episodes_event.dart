// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'underseen_episodes_bloc.dart';

abstract class UnderseenEpisodesEvent extends Equatable {
  const UnderseenEpisodesEvent();

  @override
  List<Object> get props => [];
}

class UnderseenEpisodesGetEvent extends UnderseenEpisodesEvent {}

class UnderSeenTitlesGetEvent extends UnderseenEpisodesEvent {
  final List<WatchedEpisode> underseenEpisodes;
  const UnderSeenTitlesGetEvent({
    required this.underseenEpisodes,
  });
  @override
  List<Object> get props => super.props..add(underseenEpisodes);
}

class UnderSeenTitlesCompleteEvent extends UnderseenEpisodesEvent {
  final WatchedEpisode episode;
  const UnderSeenTitlesCompleteEvent({
    required this.episode,
  });

  @override
  List<Object> get props => super.props..add(episode);
}
