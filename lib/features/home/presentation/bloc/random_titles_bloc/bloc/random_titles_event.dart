part of 'random_titles_bloc.dart';

sealed class RandomTitlesEvent extends Equatable {
  const RandomTitlesEvent();

  @override
  List<Object> get props => [];
}

final class RandomTitlesGetEvent extends RandomTitlesEvent {}
