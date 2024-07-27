import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Profile extends Equatable {
  static const tableName = 'profile';
  final String id;
  final String userName;
  final String? avatarUrl;
  const Profile({
    required this.id,
    required this.userName,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, userName, avatarUrl];

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  toJson() => _$ProfileToJson(this);
}
