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
    // on<AuthListenEvent>(_onListen);
    on<AuthStatusEvent>(_onIsAuth);
  }

  Future<void> _onIsAuth(AuthStatusEvent event, Emitter<AuthState> emit) async {
    final isAuth = await repository.isAuth();
    if (isAuth) {
      emit(AuthorizedState());
    } else {
      emit(NotAuthorizedState());
    }
  }

  // Future<void> _onListen(AuthListenEvent event, Emitter<AuthState> emit) async {
  //   subscription?.cancel();
  //   subscription = repository.isAuth().listen((event) {
  //     if (event) {
  //       add(const AuthChangedEvent(isAuth: true));
  //     } else {
  //       add(const AuthChangedEvent(isAuth: false));
  //     }
  //   });
  // }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
