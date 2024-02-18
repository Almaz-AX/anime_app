// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/features/search/domain/usecases/get_searched_titles.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';

import '../../../../core/domain/usecases/get_random_title.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/search_titles.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchedTitles getSearchedTitles;
  final GetRandomTitle getRandomTitle;

  SearchBloc({
    required this.getSearchedTitles,
    required this.getRandomTitle,
  }) : super(SearchInitialState()) {
    on<RandomTitleEvent>(_onGetRandomTitle);
    on<SearchTitlesEvent>(_onGetSearchedTitles, transformer: (events, mapper) {
      return events
          .debounceTime(const Duration(milliseconds: 300))
          .asyncExpand(mapper);
    });
    on<SearchTitlesNextPageEvent>(_onSearchTitlesNextPage,
        transformer: droppable());
  }

  Future<void> _onGetSearchedTitles(
      SearchTitlesEvent event, Emitter<SearchState> emit) async {
    if (event.query.length < 3) {
      return;
    }
    emit(SearchLoadingState());
    final failureOrSearchedTitles =
        await getSearchedTitles(Params(query: event.query));
    failureOrSearchedTitles.fold(
        (failure) =>
            emit(SearchErrorState(message: _mapFailureToMessage(failure))),
        (searchTitles) => emit(SearchLoadedState(
            query: event.query,
            titles: searchTitles.list,
            searchTitles: searchTitles,
            pages: searchTitles.pagination.pages)));
  }

  Future<void> _onSearchTitlesNextPage(
      SearchTitlesNextPageEvent event, Emitter<SearchState> emit) async {
    if (event.currentTitleIndex == state.titles.length - 2 ||
        state.titles.isEmpty) {
      return;
    }
    final nextPage = event.searchTitles.pagination.currentPage + 1;
    if (nextPage > state.pages) {
      return;
    }
    final failureOrSearchedTitles =
        await getSearchedTitles(Params(query: state.query, page: nextPage));
    failureOrSearchedTitles.fold(
        (failure) =>
            emit(SearchErrorState(message: _mapFailureToMessage(failure))),
        (searchTitles) {
      final titles = <AnimeTitle>[...state.titles, ...searchTitles.list];
      emit(SearchLoadedState(
          titles: titles,
          searchTitles: searchTitles,
          query: state.query,
          pages: state.pages));
    });
  }

  Future<void> _onGetRandomTitle(
      RandomTitleEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    final failureOrRandomTitle = await getRandomTitle(NoParams());
    failureOrRandomTitle.fold(
        (failure) =>
            emit(SearchErrorState(message: _mapFailureToMessage(failure))),
        (title) => emit(SearchRandomTitleState(title: title)));
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Что-то с интернетом';
    }
    if (failure is CasheFailure) {
      return 'Ошибка кеша';
    }
    return 'Что то пошло не так';
  }
}
