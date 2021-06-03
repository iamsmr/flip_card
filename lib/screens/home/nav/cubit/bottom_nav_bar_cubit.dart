import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flip_card/enums/enums.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit()
      : super(BottomNavBarState(selctedItem: BottomNavItem.home));

  void updateSelctedItem(BottomNavItem item) {
    if (item != state.selctedItem) {
      emit(BottomNavBarState(selctedItem: item));
    }
  }
}
