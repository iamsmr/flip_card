import 'package:flip_card/constant/constant.dart';
import 'package:flip_card/helper/validation.dart';
import 'package:flip_card/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ForgotPassword extends StatelessWidget {
  static const String routeName = "/forgotPassword";
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ForgotPassword(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                height: size.width * 0.65,
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
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Forgot password",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 26),
                margin: EdgeInsets.fromLTRB(30, 130, 30, 30),
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
                child: Form(
                  key: _formkey,
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      LoginTextFromField(
                        hintText: "Email",
                        validation: Validation.emailValidation,
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () {
                          if(_formkey.currentState!.validate()){

                          }
                        },
                        height: 57,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minWidth: double.infinity,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text(
                          "Send",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(50),
                child: Text(
                  "Check your email we have send you a verification code ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff9A9494), height: 1.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
