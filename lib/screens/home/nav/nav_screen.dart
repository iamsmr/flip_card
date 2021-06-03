import 'package:flip_card/blocs/auth/auth_bloc.dart';
import 'package:flip_card/enums/bottom_nav_item.dart';
import 'package:flip_card/screens/home/nav/cubit/bottom_nav_bar_cubit.dart';
import 'package:flip_card/screens/home/nav/widget/bottom_nav_bar.dart';
import 'package:flip_card/screens/home/nav/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  Map<BottomNavItem, IconData> _items = {
    BottomNavItem.home: Icons.home,
    BottomNavItem.createCard: Icons.playlist_add,
    BottomNavItem.createDeck: Icons.create_new_folder_rounded,
    BottomNavItem.profile: Icons.person,
  };

  final Map<BottomNavItem, GlobalKey<NavigatorState>> navigatorKeys = {
    BottomNavItem.home: GlobalKey<NavigatorState>(),
    BottomNavItem.createCard: GlobalKey<NavigatorState>(),
    BottomNavItem.createDeck: GlobalKey<NavigatorState>(),
    BottomNavItem.profile: GlobalKey<NavigatorState>()
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          return Scaffold(
           
            body: Stack(
              children: _items
                  .map((item, _) => MapEntry(item,
                      _buildOffstageWidget(item, state.selctedItem == item)))
                  .values
                  .toList(),
            ),
            bottomNavigationBar: BottomNavBar(
              items: _items,
              selectedItem: state.selctedItem,
              onTap: (int index) {
                final selectedItem = _items.keys.toList()[index];
                _selectBottomNavItem(
                  context,
                  selectedItem,
                  selectedItem == state.selctedItem,
                );
              },
            ),
          );
        },
      ),
    );
  }

  _selectBottomNavItem(
    BuildContext context,
    BottomNavItem selectedItem,
    bool isSameItem,
  ) {
    if (isSameItem) {
      navigatorKeys[selectedItem]!
          .currentState
          ?.popUntil((route) => route.isFirst);
    }
    context.read<BottomNavBarCubit>().updateSelctedItem(selectedItem);
  }

  Widget _buildOffstageWidget(BottomNavItem currentItem, bool isSelected) {
    return Offstage(
      offstage: !isSelected,
      child: TabNavigator(
        item: currentItem,
        navigatorKey: navigatorKeys[currentItem]!,
      ),
    );
  }
}
