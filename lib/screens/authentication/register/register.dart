import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final Function toggleScreen;

  const RegisterScreen(this.toggleScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Text("Login Screen"),
      ),
    );
  }
}
