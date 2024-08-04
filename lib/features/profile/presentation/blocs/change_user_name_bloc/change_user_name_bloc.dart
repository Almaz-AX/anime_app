import 'package:anime_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_user_name_event.dart';
part 'change_user_name_state.dart';

class ChangeUserNameBloc
    extends Bloc<ChangeUserNameEvent, ChangeUserNameState> {
  final ProfileRepository repository;
  ChangeUserNameBloc({required this.repository})
      : super(const ChangeUserNameState(status: ChangeUserNameStatus.initial)) {
    on<ChangeUserNameCheckEvent>(_onChangeUserNameCheck);
    on<ChangeUserNameSendEvent>(_onChangeUserNameSend);
  }
  Future<void> _onChangeUserNameCheck(
      ChangeUserNameCheckEvent event, Emitter emit) async {
    emit(state.copyWith(
        status: ChangeUserNameStatus.loading, newUserName: event.newUserName));
    final userNameIsUse = await repository.userNameIsUse(event.newUserName);
    if (userNameIsUse) {
      emit(state.copyWith(status: ChangeUserNameStatus.nameIsUsed));
      return;
    }
    emit(state.copyWith(status: ChangeUserNameStatus.nameIsNotUsed));
  }

  Future<void> _onChangeUserNameSend(
      ChangeUserNameSendEvent event, Emitter emit) async {
    emit(state.copyWith(status: ChangeUserNameStatus.loading));
    await repository.changeProfileName(state.newUserName);
    emit(state.copyWith(status: ChangeUserNameStatus.nameIsChanged));
  }
}
