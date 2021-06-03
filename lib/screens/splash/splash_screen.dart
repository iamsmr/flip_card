import 'dart:async';

import 'package:flip_card/blocs/blocs.dart';
import 'package:flip_card/screens/home/nav/cubit/bottom_nav_bar_cubit.dart';
import 'package:flip_card/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/splash";
  static Route route() {
    return MaterialPageRoute(builder: (_) => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 0), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Wrapper(),
        ),
      );
    });
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(6.123234262925839e-17, 1),
              end: Alignment(-1, 6.123234262925839e-17),
              colors: [
                Color.fromRGBO(138, 150, 255, 1),
                Color.fromRGBO(134, 144, 227, 1)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return BlocProvider<BottomNavBarCubit>(
            create: (_) => BottomNavBarCubit(),
            child: NavScreen(),
          );
        }
        return Authentication();
      },
    );
  }
}
