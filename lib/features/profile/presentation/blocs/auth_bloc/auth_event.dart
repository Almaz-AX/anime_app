part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthStatusChangedEvent extends AuthEvent {
  final bool isAuth;
  const AuthStatusChangedEvent(this.isAuth);
  @override
  // TODO: implement props
  List<Object> get props => [isAuth];
}
