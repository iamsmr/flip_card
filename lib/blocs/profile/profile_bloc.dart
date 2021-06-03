import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flip_card/blocs/auth/auth_bloc.dart';
import 'package:flip_card/models/Failure.dart';
import 'package:flip_card/models/user.dart';
import 'package:flip_card/repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  final AuthBloc _authBloc;

  ProfileBloc({
    required ProfileRepository profileRepository,
    required AuthBloc authBloc,
  })  : _profileRepository = profileRepository,
        _authBloc = authBloc,
        super(ProfileState.initial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileLoadUser) {
      yield* _mapProfileLoadUserToState(event);
    }
  }

  Stream<ProfileState> _mapProfileLoadUserToState(
      ProfileLoadUser event) async* {
    yield state.copyWith(status: ProfileStatus.loading);
    try {
      final user = await _profileRepository.getUserWithId(
        userId: event.userId!,
      );
      yield state.copyWith(user: user, status: ProfileStatus.loaded);
    } catch (e) {
      state.copyWith(
        status: ProfileStatus.error,
        failure: const Failure(message: "We ware unable to load user"),
      );
    }
  }
}
