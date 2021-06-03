import 'package:flip_card/blocs/blocs.dart';
import 'package:flip_card/config/custom_route.dart';
import 'package:flip_card/repositories/repositories.dart';
import 'package:flip_card/screens/screens.dart';
import 'package:flutter/material.dart';

import 'package:flip_card/enums/bottom_nav_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = "/";
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;
  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilder = _routeBuilder();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateRoute: CoustomRoute.onGenerateNestedRoute,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilder[initialRoute]!(context),
          ),
        ];
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilder() {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.home:
        return HomeScreen();
      case BottomNavItem.createCard:
        return CreateCardScreen();
      case BottomNavItem.createDeck:
        return CreateDecksScreen();
      case BottomNavItem.profile:
        return BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
              authBloc: context.read<AuthBloc>(),
              profileRepository: context.read<ProfileRepository>())
            ..add(
              ProfileLoadUser(userId: context.read<AuthBloc>().state.user!.uid),
            ),
          child: ProfileScreen(),
        );
      default:
        return Scaffold();
    }
  }
}
