import 'package:flip_card/models/models.dart';
import 'package:flip_card/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CreateCardScreen extends StatelessWidget {
  final List<Decks> decks = [
    Decks(
        title: "Math",
        date: DateTime.now(),
        color: Colors.pink,
        creator: User.empty),
    Decks(
        title: "Science",
        date: DateTime.now(),
        color: Colors.pink,
        creator: User.empty),
    Decks(
        title: "Social",
        date: DateTime.now(),
        color: Colors.pink,
        creator: User.empty),
    Decks(
        title: "Opt math",
        date: DateTime.now(),
        color: Colors.pink,
        creator: User.empty),
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
    return Scaffold(
      body: CustomAppBar(
        header: Column(
          children: [
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Card",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                    borderSide: BorderSide(color: Colors.grey, width: .5),
                  ),
                ),
                onChanged: (vla) {},
                items: decks
                    .map(
                      (deck) => DropdownMenuItem(
                        child: Text(deck.title),
                        value: deck.title,
                      ),
                    )
                    .toList(),
              ),
              Spacer(),
              ColorPicker(
                colors: colors,
                selectedColor: Color(0xffFFE58A),
                onTap: (val) {},
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
    );
  }
}
