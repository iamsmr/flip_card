import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flash_card/models/models.dart';
import 'package:flutter/material.dart';

part 'create_card_state.dart';

class CreateCardCubit extends Cubit<CreateCardState> {
  CreateCardCubit() : super(CreateCardState.initila());

  void decksSelectionChange(Decks deck) {
    emit(state.copyWith(status: CreateCardStatus.initial, selectedDecks: deck));
  }

  void fronTextChanges(String text) {
    emit(state.copyWith(status: CreateCardStatus.initial, frontText: text));
  }

  void backTextChagnes(String text) {
    emit(state.copyWith(status: CreateCardStatus.initial, backText: text));
  }

  void onColorChnage(Color color) {
    emit(
        state.copyWith(status: CreateCardStatus.initial, selectedColor: color));
  }

  void submit() {
    try {} catch (e) {
      emit(state.copyWith(
          failure: Failure(message: "We ware unable to create card")));
    }
  }
}
