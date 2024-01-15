// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<WatchedEpisode> underseenEpisodes;
  final List<AnimeTitle> underseenTitles;
  HomeState({
    required this.status,
    this.underseenEpisodes = const <WatchedEpisode>[],
    this.underseenTitles = const <AnimeTitle>[],
  });

  @override
  List<Object> get props => [status, underseenEpisodes, underseenTitles];

  HomeState copyWith({
    HomeStatus? status,
    List<WatchedEpisode>? underseenEpisodes,
    List<AnimeTitle>? underseenTitles,
  }) {
    return HomeState(
      status: status ?? this.status,
      underseenEpisodes: underseenEpisodes ?? this.underseenEpisodes,
      underseenTitles: underseenTitles ?? this.underseenTitles,
    );
  }
}
