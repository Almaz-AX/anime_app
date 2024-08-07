part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileGetEvent extends ProfileEvent {}

final class ProfileChangeAvatarEvent extends ProfileEvent {
  final File selectedImage;
  final Profile profile;

  const ProfileChangeAvatarEvent({
    required this.selectedImage,
    required this.profile
  });
}
