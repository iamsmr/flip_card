import 'package:flash_card/repositories/repositories.dart';
import 'package:flash_card/screens/authentication/register/cubit/register_cubit.dart';
import 'package:flash_card/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/cubit/login_cubit.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle = true;

  void toggleScreen() {
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isToggle
        ? BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
            child: LoginScreen(toggleScreen),
          )
        : BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(
              authRepository: context.read<AuthRepository>(),
            ),
            child: ResisterScreen(toggleScreen),
          );
  }
}
