part of 'change_user_name_bloc.dart';

sealed class ChangeUserNameEvent extends Equatable {
  const ChangeUserNameEvent();

  @override
  List<Object> get props => [];
}

final class ChangeUserNameCheckEvent extends ChangeUserNameEvent{
  final String newUserName;

  const ChangeUserNameCheckEvent({required this.newUserName});

   @override
  List<Object> get props => [newUserName];
  
}
final class ChangeUserNameSendEvent extends ChangeUserNameEvent{
  const ChangeUserNameSendEvent();
   @override
  List<Object> get props => [];
  
}