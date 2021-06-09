import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flash_card/models/models.dart';
import 'package:flash_card/extension/extensions.dart';

class Card extends Equatable {
  final Decks? decks;
  final Color color;
  final String frontText;
  final String backText;
  final String id;
  const Card({
    required this.decks,
    required this.color,
    required this.frontText,
    required this.backText,
    required this.id,
  });

  static Card empty = Card(
    decks: Decks.empty,
    color: Colors.white,
    frontText: "",
    backText: "",
    id: "",
  );

  @override
  List<Object?> get props => [decks, color, frontText, backText, id];

  Map<String, dynamic> toDocument() {
    return {
      "decks": decks,
      "color": color.toHex(),
      "frontText": frontText,
      "backText": backText,
    };
  }

  static Future<Card?> fromDocument(DocumentSnapshot snap) async {
    final data = snap.data() as Map;
    final DocumentReference? decksRefrence = data["decks"] as DocumentReference;

    if (decksRefrence != null) {
      final decksDoc = await decksRefrence.get();
      if (decksDoc.exists) {
        return Card(
          decks: await Decks.fromDocument(decksDoc),
          color: data["color"],
          frontText: data["frontText"],
          backText: data["backText"],
          id: snap.id,
        );
      }
    }
  }

  Card copyWith({
    Decks? decks,
    Color? color,
    String? frontText,
    String? backText,
    String? id,
  }) {
    return Card(
      decks: decks ?? this.decks,
      color: color ?? this.color,
      frontText: frontText ?? this.frontText,
      backText: backText ?? this.backText,
      id: id ?? this.id,
    );
  }
}
