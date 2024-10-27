// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class DetailGetTitleEvent extends DetailEvent {
  final int id;
  const DetailGetTitleEvent(
    this.id,
  );

  @override
  List<Object> get props => [id];
}

class DetailGetWatchedEpisodesEvent extends DetailEvent {
  final List<WatchedEpisode> watchedEpisodes;
  const DetailGetWatchedEpisodesEvent({
    required this.watchedEpisodes,
  });

  @override
  List<Object> get props => [watchedEpisodes];
}

class DetailGetScoreEvent extends DetailEvent {
  final Release release;
  const DetailGetScoreEvent({
    required this.release,
  });
  @override
  List<Object> get props => [release];

}

class DetailChangeFavoriteTitleEvent extends DetailEvent {
  final int id;
  const DetailChangeFavoriteTitleEvent(
    this.id,
  );
  @override
  List<Object> get props => [id];
}
