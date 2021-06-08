import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dicks_event.dart';
part 'dicks_state.dart';

class DicksBloc extends Bloc<DicksEvent, DicksState> {
  DicksBloc() : super(DicksInitial());

  @override
  Stream<DicksState> mapEventToState(
    DicksEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
