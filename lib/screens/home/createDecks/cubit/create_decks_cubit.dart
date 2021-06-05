import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flip_card/blocs/blocs.dart';
import 'package:flip_card/models/Failure.dart';
import 'package:flip_card/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/repositories/repositories.dart';

part 'create_decks_state.dart';

class CreateDecksCubit extends Cubit<CreateDecksState> {
  final AuthBloc _authBloc;
  final DecksRepository _decksRepository;
  final ProfileBloc _profileBloc;

  CreateDecksCubit({
    required ProfileBloc profileBloc,
    required AuthBloc authBloc,
    required DecksRepository decksRepository,
  })  : _authBloc = authBloc,
        _decksRepository = decksRepository,
        _profileBloc = profileBloc,
        super(CreateDecksState.initial());

  void decksTitleChanged(String value) {
    emit(state.copyWith(
      status: CreateDecksStatus.initial,
      decksTitle: value,
    ));
  }
  void reset(){
    emit(CreateDecksState.initial());
  }

  void onColorChange(Color color) {
    emit(state.copyWith(
      status: CreateDecksStatus.initial,
      selectedColor: color,
    ));
  }

  void submit() async {
    emit(state.copyWith(status: CreateDecksStatus.submitting));
    try {
      final creator = User.empty.copyWith(id: _authBloc.state.user!.uid);
      final Decks decks = Decks(
        color: state.selectedColor,
        creator: creator,
        date: DateTime.now(),
        title: state.decksTitle,
      );

      await _decksRepository.createDecks(decks: decks);
      _profileBloc.add(ProfileLoadUser(userId: _authBloc.state.user!.uid));
      emit(state.copyWith(status: CreateDecksStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: CreateDecksStatus.error,
          failure: Failure(message: "we ware unable to create decks"),
        ),
      );
    }
  }
}
