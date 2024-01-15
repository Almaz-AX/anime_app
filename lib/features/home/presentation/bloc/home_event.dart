// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeGetUnderSeenEpisodesEvent extends HomeEvent {}

class HomeGetUnderSeenTitlesEvent extends HomeEvent {
  final List<WatchedEpisode> underseenEpisodes;
  const HomeGetUnderSeenTitlesEvent({
    required this.underseenEpisodes,
  });
  @override
  // TODO: implement props
  List<Object> get props => [underseenEpisodes];
}
