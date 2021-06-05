import 'dart:io';

import 'package:flip_card/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flip_card/blocs/profile/profile_bloc.dart';
import 'package:flip_card/helper/validation.dart';
import 'package:flip_card/models/user.dart';
import 'package:flip_card/repositories/profile/profile_repository.dart';
import 'package:flip_card/repositories/repositories.dart';
import 'package:flip_card/screens/home/nav/widget/profier_avatar.dart';
import 'package:flip_card/screens/home/profile/cubit/edit_profile_cubit.dart';
import 'package:flip_card/widgets/login_text_from_field.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreenArgs {
  final BuildContext context;
  EditProfileScreenArgs({required this.context});
}

class EditProfile extends StatelessWidget {
  final User user;
  EditProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  static const String routeName = "/editProfile";
  static Route route({required EditProfileScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(
        name: routeName,
      ),
      builder: (context) => BlocProvider<EditProfileCubit>(
        create: (_) => EditProfileCubit(
          profileRepository: context.read<ProfileRepository>(),
          storageRepository: context.read<StorageRepository>(),
          profileBloc: args.context.read<ProfileBloc>(),
        ),
        child: EditProfile(
          user: args.context.read<ProfileBloc>().state.user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.status == EditProfileStatus.error) {
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(
              message: state.failure.message,
            ),
          );
        } else if (state.status == EditProfileStatus.success) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (state.status == EditProfileStatus.submitting)
                            const LinearProgressIndicator(),
                          SizedBox(height: 40),
                          GestureDetector(
                            onTap: () => _selctedProfileImage(context),
                            child: ProfileAvatar(
                              profileImageUrl: user.photoURL,
                              profileImage: state.profileImage,
                              radius: 50,
                            ),
                          ),
                          SizedBox(height: 40),
                          LoginTextFromField(
                            hintText: "Full Name",
                            initialValue: user.displayName,
                            onChange: (val) => context
                                .read<EditProfileCubit>()
                                .nameChanged(val!),
                            validation: (val) =>
                                Validation.fullnameValidation(val),
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
                            onPressed: () {
                              _submitForm(
                                context,
                                state.status == EditProfileStatus.submitting,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _selctedProfileImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      context.read<EditProfileCubit>().imageChanged(File(pickedFile.path));
    }
  }

  _submitForm(BuildContext context, bool isSumbiting) {
    if (_formKey.currentState!.validate() && !isSumbiting) {
      context.read<EditProfileCubit>().submit();
    }
  }
}
