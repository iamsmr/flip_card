import 'package:flip_card/screens/home/nav/widget/profier_avatar.dart';
import 'package:flip_card/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flip_card/blocs/blocs.dart';
import 'package:flip_card/constant/constant.dart';
import 'package:flip_card/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(
              message: state.failure.message,
            ),
          );
        }
      },
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;

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
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthLogoutRequest());
                                },
                                color: Colors.white,
                                icon: Icon(Icons.exit_to_app),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 26),
                  margin: EdgeInsets.fromLTRB(20, 120, 20, 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromRGBO(142, 142, 142, 0.11999999731779099),
                        offset: Offset(4, 4),
                        blurRadius: 15,
                      )
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      ProfileAvatar(
                        radius: 50,
                        profileImageUrl: state.user.photoURL,
                      ),
                      SizedBox(height: 24),
                      Text(
                        state.user.displayName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        state.user.email,
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      SizedBox(height: 30),
                      MaterialButton(
                        minWidth: 200,
                        height: 50,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text("Edit Profile"),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          EditProfile.routeName,
                          arguments: EditProfileScreenArgs(context: context),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
