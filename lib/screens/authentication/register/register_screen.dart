import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return CustomAppBar(
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
              child: Form(
                key: _formkey,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    LoginTextFromField(
                      validation: Validation.fullnameValidation,
                      hintText: "Full Name",
                      onChange: (val) =>
                          context.read<RegisterCubit>().fullNameChanged(val!),
                    ),
                    const SizedBox(height: 25),
                    LoginTextFromField(
                      validation: Validation.emailValidation,
                      hintText: "Email",
                      onChange: (val) =>
                          context.read<RegisterCubit>().emailChanged(val!),
                    ),
                    const SizedBox(height: 25),
                    LoginTextFromField(
                      validation: Validation.passwordValidation,
                      hintText: "Passowrd",
                      isPassword: true,
                      onChange: (val) =>
                          context.read<RegisterCubit>().passwordChanged(val!),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate() && !isLoading) {
                          context.read<RegisterCubit>().createAccountWithCrid();
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
              footer: Row(
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
            );
          },
        ),
      ),
    );
  }
}
