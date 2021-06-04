part of 'edit_profile_cubit.dart';

enum EditProfileStatus { initial, submitting, success, error }

class EditProfileState extends Equatable {
  final File? profileImage;
  final String displayName;
  final EditProfileStatus status;
  final Failure failure;

  const EditProfileState({
    required this.profileImage,
    required this.displayName,
    required this.status,
    required this.failure,
  });

  factory EditProfileState.initial(){
    return const EditProfileState(
      profileImage: null,
      displayName: "",
      failure: Failure(),
      status: EditProfileStatus.initial,
    );
  }

  @override
  List<Object?> get props => [profileImage, displayName, status, failure];

  EditProfileState copyWith({
    File? profileImage,
    String? displayName,
    EditProfileStatus? status,
    Failure? failure,
  }) {
    return EditProfileState(
      profileImage: profileImage ?? this.profileImage,
      displayName: displayName ?? this.displayName,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
