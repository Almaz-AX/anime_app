// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitialState extends DetailState {}

class DetailLoadingState extends DetailState {}

class DetailLoadedState extends DetailState {
  final AnimeTitle title;
  final List<WatchedEpisode> watchedEpisodes;
  const DetailLoadedState({
    required this.title,
    this.watchedEpisodes = const <WatchedEpisode>[],
  });
   @override
  List<Object> get props => [title, watchedEpisodes];
}

class DetailErrorState extends DetailState {
  final String message;
  const DetailErrorState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
