import 'package:flip_card/constant/constant.dart';
import 'package:flip_card/helper/validation.dart';
import 'package:flip_card/screens/authentication/login/cubit/login_cubit.dart';
import 'package:flip_card/screens/screens.dart';
import 'package:flip_card/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleScreen;
  const LoginScreen(this.toggleScreen);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(
                  message: state.failure.message,
                ),
              );
            }
          },
          builder: (context, state) {
            bool isLoading = state.status == LoginStatus.submitting;
            return CustomAppBar(
              headerTopMargin: 230,
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an Account ?",
                    style: TextStyle(
                      color: Color(0xff585858),
                    ),
                  ),
                  TextButton(
                    onPressed: () => widget.toggleScreen(),
                    child: Text("Create"),
                  )
                ],
              ),
              header: Column(
                children: [
                  if (isLoading)
                    LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
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
              child: Form(
                key: _formkey,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    LoginTextFromField(
                      hintText: "Email",
                      validation: Validation.emailValidation,
                      onChange: (val) =>
                          context.read<LoginCubit>().emailChanged(val!),
                    ),
                    const SizedBox(height: 25),
                    LoginTextFromField(
                      hintText: "Passowrd",
                      validation: Validation.passwordValidation,
                      isPassword: true,
                      onChange: (val) =>
                          context.read<LoginCubit>().passwordChange(val!),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, ForgotPassword.routeName),
                        child: Text("Forgot Password"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      height: 57,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (!isLoading && _formkey.currentState!.validate()) {
                          context.read<LoginCubit>().loginWithCred();
                        }
                      },
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
                      onTap: () {
                        context.read<LoginCubit>().loginWithGoogleAcc();
                      },
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
            );
          },
        ),
      ),
    );
  }
}
