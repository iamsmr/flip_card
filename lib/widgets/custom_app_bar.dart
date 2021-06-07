import 'package:flip_card/constant/constant.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget header;
  final Widget child;
  final Widget? footer;
  final double? headerTopMargin;
  const CustomAppBar({
    Key? key,
    this.headerTopMargin,
    required this.header,
    required this.child,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
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
            child: SafeArea(child: header),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 26),
            margin: EdgeInsets.fromLTRB(20, headerTopMargin ?? 120, 20, 30),
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
          ),
          if (footer != null)
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 2),
              child: footer,
            )
        ],
      ),
    );
  }
}
