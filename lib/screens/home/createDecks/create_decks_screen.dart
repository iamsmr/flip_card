import 'package:flash_card/screens/home/createDecks/cubit/create_decks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDecksScreen extends StatelessWidget {
  final List<Color> colors = [
    Color(0xff8AB9FF),
    Color(0xffCCFF8A),
    Color(0xff8AFFF8),
    Color(0xffFFE58A),
    Color(0xffFFA68A),
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateDecksCubit, CreateDecksState>(
      listener: (context, state) {
        if (state.status == CreateDecksStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              message: state.failure.message,
            ),
          );
        } else if (state.status == CreateDecksStatus.success) {
          _formKey.currentState?.reset();
          context.read<CreateDecksCubit>().reset();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Decks created successfully"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: CustomAppBar(
              headerTopMargin: 150,
              header: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Create Decks",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        padding: EdgeInsets.all(20),
                        height: 240,
                        width: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(85, 85, 85, 0.25),
                              offset: Offset(3, 10),
                              blurRadius: 10,
                            )
                          ],
                          color: state.selectedColor,
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.go,
                          onChanged: (val) => context
                              .read<CreateDecksCubit>()
                              .decksTitleChanged(val),

                          style: TextStyle(fontSize: 25, color: Colors.black),
                          maxLines: null,
                          // maxLength: 20,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Give a short \nname",
                            hintStyle: TextStyle(
                              color: Color(0xff9C9C9C),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      // Spacer(),
                      ColorPicker(
                        colors: colors,
                        selectedColor: state.selectedColor,
                        onTap: (Color color) {
                          context.read<CreateDecksCubit>().onColorChange(color);
                        },
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minWidth: 150,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text("Create"),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              state.decksTitle.isNotEmpty &&
                              state.status != CreateDecksStatus.submitting) {
                            context.read<CreateDecksCubit>().submit();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
