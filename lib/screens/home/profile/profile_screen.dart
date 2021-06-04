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
        return Scaffold(
          body: CustomAppBar(
            header: Column(
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
                          context.read<AuthBloc>().add(AuthLogoutRequest());
                        },
                        color: Colors.white,
                        icon: Icon(Icons.exit_to_app),
                      )
                    ],
                  ),
                ),
              ],
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
        );
      },
    );
  }
}
