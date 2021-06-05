import 'package:flip_card/screens/home/nav/widget/profier_avatar.dart';
import 'package:flip_card/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flip_card/blocs/blocs.dart';
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
        // context.read<ProfileBloc>().add(ProfileLoadUser(userId: state.user.id));

        print(state.decks);
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              context
                  .read<ProfileBloc>()
                  .add(ProfileLoadUser(userId: state.user.id));
              throw "";
            },
            child: CustomAppBar(
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
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<ProfileBloc>()
                                .add(ProfileLoadUser(userId: state.user.id));
                          },
                          color: Colors.white,
                          icon: Icon(Icons.refresh),
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
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "My decks",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    alignment: Alignment.topLeft,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.decks.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: state.decks[index]!.color,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  state.decks[index]!.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                margin: EdgeInsets.only(right: 20),
                              ),
                            ),
                            Positioned(
                              right: 22,
                              top: 5,
                              child: GestureDetector(
                                onTap: () {
                                  deleteConformationDialgo(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.close,
                                    size: 13,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> deleteConformationDialgo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Text("Delete Conformation", style: TextStyle(fontSize: 16)),
              Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          content: ListView(
            shrinkWrap: true,
            children: [
              Text("are you sure want to delete ?"),
              SizedBox(height: 20),
              Text(
                
                "Warning: all card insid this deks will delete",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),
              ),
            ],
          ),
          actions: [
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {},
              child: Text("Delete"),
            )
          ],
        );
      },
    );
  }
}
