import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/models/anime_title.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_title.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetTitle getTitle;
  DetailBloc({required this.getTitle}) : super(DetailInitialState()) {
    on<DetailGetTitleEvent>(_onGetTitle);
  }

  Future<void> _onGetTitle(
      DetailGetTitleEvent event, Emitter<DetailState> emit) async {
    emit(DetailLoadingState());
    final failureOrTitle = await getTitle(Params(id: event.id));
    failureOrTitle.fold(
        (failure) =>
            emit(DetailErrorState(message: _mapFailureToMessage(failure))),
        (title) => emit(DetailLoadedState(
              title: title,
            )));
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
