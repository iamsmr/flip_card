part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final List<Decks?> decks;
  final User user;
  final ProfileStatus status;
  final Failure failure;

  const ProfileState({
    required this.decks,
    required this.user,
    required this.status,
    required this.failure,
  });

  factory ProfileState.initial() {
    return ProfileState(
      user: User.empty,
      status: ProfileStatus.initial,
      failure: Failure(),
      decks: [],
    );
  }

  @override
  List<Object> get props => [user, status, failure,decks];

  ProfileState copyWith({
    List<Decks?>? decks,
    User? user,
    ProfileStatus? status,
    Failure? failure,
  }) {
    return ProfileState(
      decks: decks ?? this.decks,
      user: user ?? this.user,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
