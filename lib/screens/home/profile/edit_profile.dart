import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flash_card/helper/image_helper.dart';
import 'package:flash_card/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flash_card/repositories/repositories.dart';
import 'package:flash_card/models/models.dart';
import 'package:flash_card/helper/validation.dart';
import 'package:flash_card/blocs/blocs.dart';

import 'package:flash_card/screens/home/nav/widget/profier_avatar.dart';
import 'package:flash_card/screens/home/profile/cubit/edit_profile_cubit.dart';

class EditProfileScreenArgs {
  final BuildContext context;
  EditProfileScreenArgs({required this.context});
}

class EditProfile extends StatelessWidget {
  final User user;
  EditProfile({required this.user});
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
            builder: (_) => ErrorDialog(message: state.failure.message),
          );
        } else if (state.status == EditProfileStatus.success) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(title: Text("Edit Profile"), elevation: 0),
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.30,
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.only(
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
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () => _selctedProfileImage(context),
                            child: ProfileAvatar(
                              profileImageUrl: user.photoURL,
                              profileImage: state.profileImage,
                              radius: 70,
                            ),
                          ),
                          const SizedBox(height: 40),
                          LoginTextFromField(
                            hintText: "Full Name",
                            initialValue: user.displayName,
                            onChange: (val) => context
                                .read<EditProfileCubit>()
                                .nameChanged(val!),
                            validation: (val) =>
                                Validation.fullnameValidation(val),
                          ),
                          const SizedBox(height: 40),
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
    final pickedFile = await ImageHelper.pickImageFromGallery(
      context: context,
      cropStyle: CropStyle.circle,
      title: "Profile Image",
    );
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
