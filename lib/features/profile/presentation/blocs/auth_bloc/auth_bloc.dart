import 'dart:async';

import 'package:anime_app/features/profile/domain/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  StreamSubscription<bool>? subscription;
  AuthBloc({required this.repository}) : super(AuthUnknownState()) {
    _onListen();
    on<AuthStatusChangedEvent>(_onIsAuth);
  }

  Future<void> _onIsAuth(
      AuthStatusChangedEvent event, Emitter<AuthState> emit) async {
    if (event.isAuth) {
      emit(AuthorizedState());
    } else {
      emit(NotAuthorizedState());
    }
  }

  Future<void> _onListen() async {
    subscription?.cancel();
    subscription = repository.isAuth().listen((event) {
      if (event) {
        add(const AuthStatusChangedEvent(true));
      } else {
        add(const AuthStatusChangedEvent(false));
      }
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
