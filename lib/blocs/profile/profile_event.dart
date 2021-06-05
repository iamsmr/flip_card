part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadUser extends ProfileEvent {
  final String? userId;
  ProfileLoadUser({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class ProfileUpdateDecks extends ProfileEvent {
  final List<Decks?> decks;

  const ProfileUpdateDecks({required this.decks});

  @override
  List<Object?> get props => [decks];
}
