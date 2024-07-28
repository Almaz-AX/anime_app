part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileUser extends ProfileState {
  final Profile user;

  const ProfileUser({required this.user});
   @override
  List<Object> get props => [user];
  
}
