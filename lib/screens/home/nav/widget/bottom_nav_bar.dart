import 'package:flutter/material.dart';
import 'package:flash_card/enums/enums.dart';

class BottomNavBar extends StatelessWidget {
  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selectedItem;
  final Function(int) onTap;
  const BottomNavBar({
    required this.items,
    required this.selectedItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Color(0xffA3A3A3),
      selectedItemColor: Theme.of(context).primaryColor,
      currentIndex: items.keys.toList().indexOf(selectedItem),
      items: items
          .map((item, icon) {
            return MapEntry(
              item.toString(),
              BottomNavigationBarItem(
                icon: Icon(icon),
                label: "",
              ),
            );
          })
          .values
          .toList(),
    );
  }
}
