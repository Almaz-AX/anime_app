import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/data/models/release.dart';
import '../../../../core/domain/usecases/get_random_title.dart';
import '../../domain/usecases/get_searched_titles.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchedTitles getSearchedTitles;
  final GetRandomReleases getRandomTitle;

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
            emit(const SearchErrorState(message: 'Что то пошло не так')),
        (releases) => emit(SearchLoadedState(
              query: event.query,
              releases: releases,
            )));
  }

  Future<void> _onGetRandomTitle(
      RandomTitleEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    final failureOrRandomTitle = await getRandomTitle(const RandomParams());
    failureOrRandomTitle.fold(
        (failure) =>
            emit(const SearchErrorState(message: 'Что то пошло не так')),
        (title) => emit(SearchRandomTitleState(release: title.first)));
  }
}
