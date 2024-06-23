part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthUnknownState extends AuthState{}

final class AuthorizedState extends AuthState {}

final class NotAuthorizedState extends AuthState {}
