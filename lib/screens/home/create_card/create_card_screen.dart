import 'package:flash_card/constant/constant.dart';
import 'package:flash_card/models/models.dart';
import 'package:flash_card/screens/home/create_card/cubit/create_card_cubit.dart';
import 'package:flash_card/widgets/widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCardScreen extends StatelessWidget {
  final List<Decks> decks = [
    Decks(
      title: "Math",
      date: DateTime.now(),
      color: Colors.pink,
      creator: User.empty,
    ),
    Decks(
      title: "Science",
      date: DateTime.now(),
      color: Colors.pink,
      creator: User.empty,
    ),
    Decks(
      title: "Social",
      date: DateTime.now(),
      color: Colors.pink,
      creator: User.empty,
    ),
    Decks(
      title: "Opt math",
      date: DateTime.now(),
      color: Colors.pink,
      creator: User.empty,
    )
  ];
  final List<Color> colors = [
    Color(0xff8AB9FF),
    Color(0xffCCFF8A),
    Color(0xff8AFFF8),
    Color(0xffFFE58A),
    Color(0xffFFA68A),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<CreateCardCubit, CreateCardState>(
        listener: (context, state) {
          if (state.status == CreateCardStatus.error) {
            showDialog(
              context: context,
              builder: (context) {
                return ErrorDialog(message: state.failure.message);
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              height: size.height,
              width: size.width,
              color: const Color(0xffF1F1F1),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: size.width * 0.95,
                    decoration: const BoxDecoration(
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
                            child: Text(
                              "Create Card",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        shadowContainer(
                          topMargin: 120,
                          child: Form(
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText: "Select Decks",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: .5,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: .5,
                                      ),
                                    ),
                                  ),
                                  // value: decks[0],
                                  onChanged: (deck) => context
                                      .read<CreateCardCubit>()
                                      .decksSelectionChange(deck as Decks),
                                  items: decks.map((deck) {
                                    return DropdownMenuItem(
                                      child: Text(deck.title),
                                      value: deck,
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  height: 320,
                                  child: FlipCard(
                                    front: flipCardFrontSide(context, state),
                                    back: flipCardBackSide(context, state),
                                  ),
                                ),
                                SizedBox(height: 30),
                                ColorPicker(
                                  colors: colors,
                                  selectedColor: state.selectedColor,
                                  onTap: (val) => context
                                      .read<CreateCardCubit>()
                                      .onColorChnage(val),
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
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget flipCardFrontSide(BuildContext context, CreateCardState state) {
    return filpCardContainer(
      color: state.selectedColor,
      child: Column(
        children: [
          buildFlipCardTextField(
            hintText: "Write Someting It will \nDisplay In the fron Side..",
            onChange: (val) =>
                context.read<CreateCardCubit>().fronTextChanges(val),
          ),
          Spacer(),
          Icon(Icons.touch_app_outlined, color: Colors.grey[600]),
          const SizedBox(height: 10),
          Text(
            "Tap to flip the card",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  Widget flipCardBackSide(BuildContext context, CreateCardState state) {
    return filpCardContainer(
      color: state.selectedColor,
      child: Column(
        children: [
          buildFlipCardTextField(
            hintText: "Write Someting It will \nDisplay In the Back Side..",
            onChange: (val) =>
                context.read<CreateCardCubit>().backTextChagnes(val),
          ),
          Spacer(),
          Icon(Icons.touch_app_outlined, color: Colors.grey[600]),
          const SizedBox(height: 10),
          Text(
            "Tap to flip the card",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  Widget filpCardContainer({Color? color, Widget? child}) {
    return Container(
      child: child,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(85, 85, 85, 0.25),
            offset: Offset(3, 10),
            blurRadius: 10,
          )
        ],
      ),
    );
  }

  Widget buildFlipCardTextField({
    required Function(String) onChange,
    String? hintText,
  }) {
    return TextFormField(
      textInputAction: TextInputAction.go,
      onChanged: onChange,
      style: TextStyle(fontSize: 25, color: Colors.black),
      maxLines: null,
      inputFormatters: [LengthLimitingTextInputFormatter(200)],
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey[600]),
        border: InputBorder.none,
        hintText: hintText,
      ),
    );
  }

  Widget shadowContainer({double? height, Widget? child, double? topMargin}) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 26),
      margin: EdgeInsets.fromLTRB(20, topMargin ?? 20, 20, 30),
      width: double.infinity,
      child: child,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(142, 142, 142, 0.11999999731779099),
            offset: Offset(4, 4),
            blurRadius: 15,
          )
        ],
      ),
    );
  }
}
