import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flip_card/constant/constant.dart';
import 'package:flip_card/helper/validation.dart';
import 'package:flip_card/screens/authentication/register/cubit/register_cubit.dart';
import 'package:flip_card/widgets/widgets.dart';

class ResisterScreen extends StatefulWidget {
  final Function toggleScreen;
  const ResisterScreen(this.toggleScreen);

  @override
  _ResisterScreenState createState() => _ResisterScreenState();
}

class _ResisterScreenState extends State<ResisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.error) {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(),
              );
            }
          },
          builder: (context, state) {
            bool isLoading = state.status == RegisterStatus.submitting;
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
                    child: SafeArea(
                      child: Column(
                        children: [
                          if (isLoading)
                            LinearProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          const SizedBox(height: 40),
                          const Text(
                            "Register",
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
                          color: Color.fromRGBO(
                              142, 142, 142, 0.11999999731779099),
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
                            validation: Validation.fullnameValidation,
                            hintText: "Full Name",
                            onChange: (val) => context
                                .read<RegisterCubit>()
                                .fullNameChanged(val!),
                          ),
                          const SizedBox(height: 25),
                          LoginTextFromField(
                            validation: Validation.emailValidation,
                            hintText: "Email",
                            onChange: (val) => context
                                .read<RegisterCubit>()
                                .emailChanged(val!),
                          ),
                          const SizedBox(height: 25),
                          LoginTextFromField(
                            validation: Validation.passwordValidation,
                            hintText: "Passowrd",
                            isPassword: true,
                            onChange: (val) => context
                                .read<RegisterCubit>()
                                .passwordChanged(val!),
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate() &&
                                  !isLoading) {
                                context
                                    .read<RegisterCubit>()
                                    .createAccountWithCrid();
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
                              "Register",
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
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an Account ?",
                          style: TextStyle(
                            color: Color(0xff585858),
                          ),
                        ),
                        TextButton(
                          onPressed: () => widget.toggleScreen(),
                          child: Text("login"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
