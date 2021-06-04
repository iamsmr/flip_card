import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flip_card/models/Failure.dart';
import 'package:flutter/material.dart';

part 'create_decks_state.dart';

class CreateDecksCubit extends Cubit<CreateDecksState> {
  CreateDecksCubit() : super(CreateDecksState.initial());

  void decksTitleChanged(String value) {
    emit(state.copyWith(status: CreateDecksStatus.initial, decksTitle: value));
  }

  void onColorChange(Color color) {
    emit(state.copyWith(
        status: CreateDecksStatus.initial, selectedColor: color));
  }

  void submit() {
    // TODO://
  }
}
