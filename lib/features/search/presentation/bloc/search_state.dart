// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

enum SearchStatus { empty, loading, randomTitle, failure }

abstract class SearchState extends Equatable {
  final String query;


  const SearchState({
    this.query = '',
  });
}

class SearchInitialState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoadedState extends SearchState {
  final List<Release> releases;
  const SearchLoadedState({
    required this.releases,
    required super.query,
  });
  @override
  List<Object?> get props => [releases, super.query];
}

class SearchErrorState extends SearchState {
  final String message;
  const SearchErrorState({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}

class SearchRandomTitleState extends SearchState {
  final Release release;
  const SearchRandomTitleState({
    required this.release,
  });
  @override
  List<Object?> get props => [release];
}
