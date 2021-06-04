import 'package:flip_card/screens/home/createDecks/cubit/create_decks_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flip_card/constant/constant.dart';
import 'package:flip_card/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flip_card/extension/extensions.dart';

class CreateDecksScreen extends StatelessWidget {
  final List<Color> colors = [
    Color(0xff8AB9FF),
    Color(0xffCCFF8A),
    Color(0xff8AFFF8),
    Color(0xffFFE58A),
    Color(0xffFFA68A),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateDecksCubit, CreateDecksState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: CustomAppBar(
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
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
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
                        print(color.toHex());
                        print(HexColor.fromHex(color.toHex()));
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
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ColorPicker extends StatelessWidget {
  final List<Color> colors;
  final Function(Color) onTap;
  final Color selectedColor;

  const ColorPicker({
    Key? key,
    required this.colors,
    required this.selectedColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: colors.map((color) => _buildColor(color)).toList(),
      ),
    );
  }

  Widget _buildColor(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        onTap(color);
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: isSelected ? Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
