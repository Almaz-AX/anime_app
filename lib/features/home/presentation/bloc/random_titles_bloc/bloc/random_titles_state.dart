part of 'random_titles_bloc.dart';

sealed class RandomTitlesState extends Equatable {
  const RandomTitlesState();

  @override
  List<Object> get props => [];
}

final class RandomTitlesInitial extends RandomTitlesState {}

final class RandomTitlesLoaded extends RandomTitlesState {
  final List<AnimeTitle> randomTitles;

  const RandomTitlesLoaded({required this.randomTitles});
}
