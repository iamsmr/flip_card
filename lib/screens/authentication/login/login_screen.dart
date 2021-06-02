import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final Function toggleScreen;
  const LoginScreen(this.toggleScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Text("Login Screen"),
      ),
    );
  }
}
