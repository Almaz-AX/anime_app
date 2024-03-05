// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:anime_app/core/error/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:anime_app/features/home/data/models/title_updates.dart';

import '../../../../../core/data/models/anime_title.dart';
import '../../../domain/usecases/get_title_updates.dart';

part 'last_updates_event.dart';
part 'last_updates_state.dart';

class LastUpdatesBloc extends Bloc<LastUpdatesEvent, LastUpdatesState> {
  final GetTitleUpdates getTitleUpdates;
  LastUpdatesBloc({
    required this.getTitleUpdates,
  }) : super(LastUpdatesInitial()) {
    on<LastUpdatesLoadPageEvent>(
      _onLastUpdatesLoad,
    );
  }

  Future<void> _onLastUpdatesLoad(LastUpdatesLoadPageEvent event, emit) async {
    final titleUpdatesOrFailure =
        await getTitleUpdates(Params(page: event.currenPage + 1));
    titleUpdatesOrFailure.fold(
        (failure) => emit(LastUpdatesFailureState(failure: failure)),
        (titleUpdates) => emit(LastUpdatesSuccessState(
            titleUpdates: titleUpdates,
            titles: [...event.titles, ...titleUpdates.list],
            pageIsEmtpy: titleUpdates.list.isEmpty)));
  }
}
