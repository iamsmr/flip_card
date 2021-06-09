import 'package:flutter/material.dart';

class DecksScreen extends StatelessWidget {
  static const routeName = "/desks";
  static route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => DecksScreen(),
    );
  }

  const DecksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Decks"), elevation: 0),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.30,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(),
          )
        ],
      ),
    );
  }
}
