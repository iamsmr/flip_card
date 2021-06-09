import 'package:flash_card/blocs/blocs.dart';
import 'package:flash_card/config/custom_route.dart';
import 'package:flash_card/repositories/repositories.dart';
import 'package:flash_card/screens/home/createDecks/cubit/create_decks_cubit.dart';
import 'package:flash_card/screens/home/create_card/cubit/create_card_cubit.dart';
import 'package:flash_card/screens/screens.dart';
import 'package:flutter/material.dart';

import 'package:flash_card/enums/bottom_nav_item.dart';
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
        return BlocProvider<CreateCardCubit>(
          create: (context) => CreateCardCubit(),
          child: CreateCardScreen(),
        );
      case BottomNavItem.createDeck:
        return BlocProvider<CreateDecksCubit>(
          create: (context) => CreateDecksCubit(
            profileBloc: context.read<ProfileBloc>(),
            authBloc: context.read<AuthBloc>(),
            decksRepository: context.read<DecksRepository>(),
          ),
          child: CreateDecksScreen(),
        );
      case BottomNavItem.profile:
        return ProfileScreen();
      default:
        return Scaffold();
    }
  }
}
