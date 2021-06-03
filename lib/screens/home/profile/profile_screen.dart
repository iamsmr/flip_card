import 'package:flip_card/blocs/blocs.dart';
import 'package:flip_card/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        showDialog(
          context: context,
          builder: (_) => ErrorDialog(
            message: state.failure.message,
          ),
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Text("profile page"),
          ),
        );
      },
    );
  }
}
