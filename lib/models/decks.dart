import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flip_card/config/paths.dart';
import 'package:flutter/material.dart';

import 'package:flip_card/models/user.dart';

class Decks extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final Color color;
  final User creator;
  // final List<Card> cards  TODO://
  const Decks({
    required this.id,
    required this.title,
    required this.date,
    required this.color,
    required this.creator,
  });

  static Decks empty = Decks(
    title: "",
    date: DateTime.now(),
    id: "",
    color: Colors.black,
    creator: User.empty,
  );

  String toHex(Color color) {
    return '${color.alpha.toRadixString(16).padLeft(2, '0')}'
        '${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Map<String, dynamic> toDocument() {
    return {
      "title": title,
      "date": Timestamp.fromDate(date),
      "colorCode": toHex(color),
      "user": FirebaseFirestore.instance
          .collection(Paths.users)
          .doc(creator.id)
          .path as DocumentReference
    };
  }

  Decks fromDocument(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    return Decks(
      id: snapshot.id,
      title: data["title"] ?? "",
      date: (data["date"] as Timestamp).toDate(),
      color: fromHex(data["color"]),
      creator: creator,
    );
  }

  Decks copyWith({
    String? title,
    DateTime? date,
    Color? color,
    User? creator,
    String? id,
  }) {
    return Decks(
      title: title ?? this.title,
      date: date ?? this.date,
      color: color ?? this.color,
      creator: creator ?? this.creator,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [title, date, color, creator, this.id];
}
