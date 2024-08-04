// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_user_name_bloc.dart';

enum ChangeUserNameStatus{
  initial,
  loading,
  nameIsUsed,
  nameIsNotUsed,
  nameIsChanged,
}

class ChangeUserNameState extends Equatable {
  final String newUserName;
  final ChangeUserNameStatus status;

  const ChangeUserNameState(
    {
      required this.status,
      this.newUserName = '',
    }
  );

  @override
  List<Object> get props => [newUserName, status];

  ChangeUserNameState copyWith({
    String? newUserName,
    ChangeUserNameStatus? status,
  }) {
    return ChangeUserNameState(
      newUserName: newUserName ?? this.newUserName,
      status: status ?? this.status,
    );
  }
}
