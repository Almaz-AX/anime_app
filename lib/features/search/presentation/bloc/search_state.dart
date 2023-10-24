// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

enum SearchStatus { empty, loading, randomTitle, failure }

abstract class SearchState extends Equatable {
  final String query;
  final List<AnimeTitle> titles;
  final int pages;

  const SearchState({
    this.titles = const <AnimeTitle>[],
    this.query = '',
    this.pages = 1,
  });
}

class SearchInitialState extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [
        super.titles,
      ];
}

class SearchLoadingState extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [
        super.titles,
      ];
}

class SearchLoadedState extends SearchState {
  final SearchTitles searchTitles;
  const SearchLoadedState({
    required List<AnimeTitle> titles,
    required this.searchTitles,
    required String query,
    required int pages,
  }) : super(query: query, titles: titles, pages: pages);
  @override
  // TODO: implement props
  List<Object?> get props => [super.titles, super.query];
}

class SearchErrorState extends SearchState {
  final String message;
  const SearchErrorState({
    required this.message,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class SearchRandomTitleState extends SearchState {
  final AnimeTitle title;
  const SearchRandomTitleState({
    required this.title,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [title];
}
