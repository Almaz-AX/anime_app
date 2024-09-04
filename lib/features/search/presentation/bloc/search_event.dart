// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTitlesEvent extends SearchEvent {
  final String query;

  const SearchTitlesEvent({required this.query});
  @override
  List<Object> get props => [query];
}


class RandomTitleEvent extends SearchEvent {}
