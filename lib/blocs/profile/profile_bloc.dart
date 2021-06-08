import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flash_card/blocs/auth/auth_bloc.dart';
import 'package:flash_card/models/Failure.dart';
import 'package:flash_card/models/decks.dart';
import 'package:flash_card/models/user.dart';
import 'package:flash_card/repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  final DecksRepository _decksRepository;

  ProfileBloc({
    required DecksRepository decksRepository,
    required ProfileRepository profileRepository,
    required AuthBloc authBloc,
  })  : _profileRepository = profileRepository,
        _decksRepository = decksRepository,
        super(ProfileState.initial());

  StreamSubscription<List<Future<Decks?>>>? _decksSubscription;
  @override
  Future<void> close() async {
    _decksSubscription?.cancel();
    super.close();
  }

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileLoadUser) {
      yield* _mapProfileLoadUserToState(event);
    } else if (event is ProfileUpdateDecks) {
      yield* _mapProfileUpdateDecks(event);
    }
  }

  Stream<ProfileState> _mapProfileLoadUserToState(
      ProfileLoadUser event) async* {
    yield state.copyWith(status: ProfileStatus.loading);
    try {
      final user = await _profileRepository.getUserWithId(
        userId: event.userId!,
      );

      _decksSubscription?.cancel();
      _decksSubscription = _decksRepository.getDecks(userId: user.id).listen(
        (decks) async {
          final allDecks = await Future.wait(decks);
          add(ProfileUpdateDecks(decks: allDecks));
        },
      );

      yield state.copyWith(user: user, status: ProfileStatus.loaded);
    } catch (e) {
      state.copyWith(
        status: ProfileStatus.error,
        failure: const Failure(message: "We ware unable to load user"),
      );
    }
  }

  Stream<ProfileState> _mapProfileUpdateDecks(ProfileUpdateDecks event) async* {
    yield state.copyWith(decks: event.decks);
  }
}
