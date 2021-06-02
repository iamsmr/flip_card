import 'package:flip_card/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
    
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nav Screen"),
          leading: Text(""),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequest());
              },
            )
          ],
        ),
        body: Center(child: Text("Nav")),
      ),
    );
  }
}
