import 'package:flip_card/screens/home/profile/edit_profile.dart';
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
      case ForgotPassword.routeName:
        return ForgotPassword.route();
      default:
        return _error();
    }
  }

  static Route onGenerateNestedRoute(RouteSettings routeSettings){
    print("Nested Route: ${routeSettings.name}");
    switch(routeSettings.name){
      case EditProfile.routeName:
        return EditProfile.route();
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
