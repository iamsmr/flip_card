import 'package:flip_card/constant/constant.dart';
import 'package:flip_card/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Color(0xffF1F1F1),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height: size.width * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: primaryGradient,
              ),
              child: SafeArea(child: Container()),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  shadowContainer(
                    topMargin: 270,
                    child: Container(height: 300),
                  ),
                  SizedBox(height: 40),
                  shadowContainer(
                    child: Container(height: 200),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shadowContainer({double? height, Widget? child, double? topMargin}) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 26),
      margin: EdgeInsets.fromLTRB(20, topMargin ?? 20, 20, 30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(142, 142, 142, 0.11999999731779099),
            offset: Offset(4, 4),
            blurRadius: 15,
          )
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
