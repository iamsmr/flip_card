import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flip_card/blocs/profile/profile_bloc.dart';
import 'package:flip_card/models/Failure.dart';
import 'package:flip_card/repositories/repositories.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileRepository _profileRepository;
  final StorageRepository _storageRepository;
  final ProfileBloc _profileBloc;

  EditProfileCubit({
    required ProfileRepository profileRepository,
    required StorageRepository storageRepository,
    required ProfileBloc profileBloc,
  })  : _profileBloc = profileBloc,
        _storageRepository = storageRepository,
        _profileRepository = profileRepository,
        super(EditProfileState.initial()) {
    final user = _profileBloc.state.user;
    emit(state.copyWith(
        displayName: user.displayName, status: EditProfileStatus.initial));
  }

  void imageChanged(File file) {
    emit(state.copyWith(status: EditProfileStatus.initial, profileImage: file));
  }

  void nameChanged(String val) {
    emit(state.copyWith(status: EditProfileStatus.initial, displayName: val));
  }

  void submit() async {
    emit(state.copyWith(status: EditProfileStatus.submitting));
    try {
      final user = _profileBloc.state.user;

      var profileImageUrl = user.photoURL;

      if (state.profileImage != null) {
        profileImageUrl = await _storageRepository.uploadProfileImage(
          url: profileImageUrl,
          image: state.profileImage!,
        );
      }
      final updatedUser = user.copyWith(
        displayName: state.displayName,
        photoURL: profileImageUrl,
      );

      await _profileRepository.updateUser(user: updatedUser);
      _profileBloc.add(ProfileLoadUser(userId: user.id));
      emit(state.copyWith(status: EditProfileStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: EditProfileStatus.error,
          failure: Failure(message: "We ware unable to update your profile"),
        ),
      );
    }
  }
}
