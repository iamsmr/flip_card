import 'package:flutter/material.dart';

class LoginTextFromField extends StatelessWidget {
  final String? hintText;
  final bool isPassword;
  final void Function(String?)? onChange;
  final String? Function(String?)? validation;

  const LoginTextFromField({
    this.hintText,
    this.isPassword = false,
    this.onChange,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      onChanged: onChange,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Color(0xffF4F4F4),
        filled: true,
        hintStyle: TextStyle(color: Color(0xffC3C1C1)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
           borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: Color(0xff8892ED),
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: Color(0xffEDEDED),
            width: 1,
          ),
        ),
      ),
    );
  }
}
