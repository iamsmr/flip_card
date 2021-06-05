import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flip_card/config/paths.dart';
import 'package:flip_card/extension/hex_color_conver.dart';
import 'package:flutter/material.dart';

import 'package:flip_card/models/user.dart';

class Decks extends Equatable {
  final String? id;
  final String title;
  final DateTime date;
  final Color color;
  final User creator;
  // final List<Card> cards  TODO://
  const Decks({
    this.id,
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

  Map<String, dynamic> toDocument() {
    return {
      "title": title,
      "date": Timestamp.fromDate(date),
      "colorCode": color.toHex(),
      "creator":
          FirebaseFirestore.instance.collection(Paths.users).doc(creator.id)
    };
  }

  static Future<Decks?> fromDocument(DocumentSnapshot snapshot) async {
    final data = snapshot.data() as Map;
    final DocumentReference? creatorRef = data["creator"] as DocumentReference;
    if (creatorRef != null) {
      final creatorDOc = await creatorRef.get();
      if (creatorDOc.exists) {
        return Decks(
          id: snapshot.id,
          title: data["title"] ?? "",
          date: (data["date"] as Timestamp).toDate(),
          color: HexColor.fromHex(data["color"]),
          creator: User.fromDocument(creatorDOc),
        );
      }
    }
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
  List<Object?> get props => [title, date, color, creator, id];
}
