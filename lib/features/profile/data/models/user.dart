import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String userName;
  final String? avatarUrl;
  const User({
    required this.id,
    required this.userName,
    this.avatarUrl,
  });
  
  @override
  List<Object?> get props => [id, userName, avatarUrl];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  toJson() => _$UserToJson(this);
  
  
}
