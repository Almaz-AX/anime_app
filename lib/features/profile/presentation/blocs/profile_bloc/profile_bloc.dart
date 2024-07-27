import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;
  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<ProfileGetEvent>(_onProfileGetEvent);
  }
  _onProfileGetEvent(ProfileGetEvent event, emit) async {
      final profile = await repository.getProfile();
      if (profile == null) {
        throw NetworkUnauthorizedFailure();
      }
      emit(ProfileUser(user: profile));
    }
}
