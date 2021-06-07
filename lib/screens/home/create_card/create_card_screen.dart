import 'package:flash_card/constant/constant.dart';
import 'package:flash_card/models/models.dart';
import 'package:flash_card/widgets/widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:avatar_glow/avatar_glow.dart';

class CreateCardScreen extends StatelessWidget {
  final List<Decks> decks = [
    Decks(
        title: "Math",
        date: DateTime.now(),
        color: Colors.pink,
        creator: User.empty),
    Decks(
        title: "Science",
        date: DateTime.now(),
        color: Colors.pink,
        creator: User.empty),
    Decks(
        title: "Social",
        date: DateTime.now(),
        color: Colors.pink,
        creator: User.empty),
    Decks(
        title: "Opt math",
        date: DateTime.now(),
        color: Colors.pink,
        creator: User.empty),
  ];
  final List<Color> colors = [
    Color(0xff8AB9FF),
    Color(0xffCCFF8A),
    Color(0xff8AFFF8),
    Color(0xffFFE58A),
    Color(0xffFFA68A),
  ];
  GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Create Card",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    shadowContainer(
                      topMargin: 120,
                      child: Form(
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: "Select Decks",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: .5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: .5),
                                ),
                              ),
                              onChanged: (vla) {},
                              items: decks
                                  .map(
                                    (deck) => DropdownMenuItem(
                                      child: Text(deck.title),
                                      value: deck.title,
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 320,
                              child: FlipCard(
                                flipOnTouch: false,
                                key: _cardKey,
                                front: buildFlipCard(
                                  color: Color.fromRGBO(255, 229, 138, 1),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        textInputAction: TextInputAction.go,
                                        onChanged: (val) {},
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.black),
                                        maxLines: null,
                                        // maxLength: 20,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(100),
                                        ],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              "Write something it will \ndisplay in front side...",
                                          hintStyle: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      AvatarGlow(
                                        glowColor:
                                            Theme.of(context).primaryColor,
                                        endRadius: 70.0,
                                        child: Material(
                                          elevation: 8.0,
                                          shape: CircleBorder(),
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            radius: 30,
                                            child: IconButton(
                                              onPressed: () => _cardKey
                                                  .currentState
                                                  ?.toggleCard(),
                                              icon: Icon(
                                                Icons.touch_app_outlined,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                back: buildFlipCard(
                                    color: Color.fromRGBO(255, 229, 138, 1),
                                    child: Column(children: [
                                      TextFormField(
                                        textInputAction: TextInputAction.go,
                                        onChanged: (val) {},
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.black),
                                        maxLines: null,
                                        // maxLength: 20,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(100),
                                        ],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              "Write something it will \ndisplay in Back side...",
                                          hintStyle: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      AvatarGlow(
                                        glowColor:
                                            Theme.of(context).primaryColor,
                                        endRadius: 70.0,
                                        child: Material(
                                          elevation: 8.0,
                                          shape: CircleBorder(),
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            radius: 30,
                                            child: IconButton(
                                              onPressed: () => _cardKey
                                                  .currentState
                                                  ?.toggleCard(),
                                              icon: Icon(
                                                Icons.touch_app_outlined,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ])),
                              ),
                            ),
                            SizedBox(height: 30),
                            ColorPicker(
                              colors: colors,
                              selectedColor: Color(0xffFFE58A),
                              onTap: (val) {},
                            ),
                            SizedBox(height: 20),
                            MaterialButton(
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              minWidth: 150,
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Text("Create"),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(142, 142, 142, 0.11999999731779099),
            offset: Offset(4, 4),
            blurRadius: 15,
          )
        ],
      ),
      child: child,
    );
  }

  Container buildFlipCard({Color? color, Widget? child}) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(85, 85, 85, 0.25),
            offset: Offset(3, 10),
            blurRadius: 10,
          )
        ],
      ),
      child: child,
    );
  }
}






      // CustomAppBar(
        // header: 
      //   child: SingleChildScrollView(
      //     child: 
      //   ),
      // ),