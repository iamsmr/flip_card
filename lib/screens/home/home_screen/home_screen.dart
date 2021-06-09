import 'package:flash_card/blocs/blocs.dart';
import 'package:flash_card/constant/constant.dart';
import 'package:flash_card/models/decks.dart';
import 'package:flash_card/screens/home/nav/widget/profier_avatar.dart';
import 'package:flash_card/screens/screens.dart';
import 'package:flash_card/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          body: state.status == ProfileStatus.loading
              ? Center(child: CircularProgressIndicator())
              : Container(
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
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.notes_outlined,
                                        color: Colors.white),
                                    Spacer(),
                                    ProfileAvatar(
                                      radius: 25,
                                      profileImageUrl: state.user.photoURL,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Wellcome Back",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xffDEDEDE),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Rarge Mind",
                                  style: TextStyle(
                                    fontSize: 37,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            shadowContainer(
                              topMargin: 270,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "My Decks",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                      ),
                                      itemCount: state.decks.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context, DecksScreen.routeName),
                                          child: Container(
                                            height: 70,
                                            width: 50,
                                            padding: EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            child: Text(
                                              state.decks[index]!.title,
                                              textAlign: TextAlign.center,
                                            ),
                                            decoration: BoxDecoration(
                                              color: state.decks[index]!.color,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            shadowContainer(
                              child: Container(height: 200),
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

  Widget shadowContainer({double? height, Widget? child, double? topMargin}) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 26),
      margin: EdgeInsets.fromLTRB(20, topMargin ?? 20, 20, 30),
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
      child: child,
    );
  }
}
