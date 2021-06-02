import 'package:flip_card/constant/constant.dart';
import 'package:flip_card/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final Function toggleScreen;
  const LoginScreen(this.toggleScreen);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      const SizedBox(height: 40),
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Wellcome Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 26),
                margin: EdgeInsets.fromLTRB(30, 177, 30, 30),
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
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    LoginTextFromField(hintText: "Email"),
                    const SizedBox(height: 25),
                    LoginTextFromField(
                      hintText: "Passowrd",
                      isPassword: true,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Forgot Password"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () {},
                      height: 57,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {},
                      child: Material(
                        borderRadius: BorderRadius.circular(9),
                        child: Container(
                          height: 57,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(185, 182, 182, 0.5),
                                offset: Offset(0, 2),
                                blurRadius: 72,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/google_logo.png",
                                height: 29,
                                width: 29,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Continue with google",
                                  style: TextStyle(
                                    color: Color(0xff777777),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an Account ?",
                      style: TextStyle(
                        color: Color(0xff585858),
                      ),
                    ),
                    TextButton(
                      onPressed: () => toggleScreen(),
                      child: Text("Create"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
