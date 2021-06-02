import 'package:flutter/material.dart';
import '../screens/screens.dart';

class CoustomRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    print("Route: ${routeSettings.name}");
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
          settings: const RouteSettings(name: "/"),
          builder: (_) => Scaffold(),
        );
      case SplashScreen.routeName:
        return SplashScreen.route();
      default:
        return _error();
    }
  }

  static MaterialPageRoute _error() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(
          child: Text("Someting went wrong"),
        ),
      ),
    );
  }
}
