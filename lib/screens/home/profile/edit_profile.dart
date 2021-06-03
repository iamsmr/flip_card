import 'package:flip_card/helper/validation.dart';
import 'package:flip_card/screens/home/nav/widget/profier_avatar.dart';
import 'package:flip_card/widgets/login_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditProfile extends StatelessWidget {
  static const String routeName = "/editProfile";
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => EditProfile(),
    );
  }

  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.30,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {},
                  child: ProfileAvatar(radius: 60),
                ),
                SizedBox(height: 40),
                LoginTextFromField(
                  hintText: "Full Name",
                  validation: (val) => Validation.fullnameValidation(val),
                ),
                SizedBox(height: 40),
                MaterialButton(
                  minWidth: 200,
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text("Updated"),
                  onPressed: () =>
                      Navigator.pushNamed(context, EditProfile.routeName),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
