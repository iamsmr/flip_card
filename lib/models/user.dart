import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String displayName;
  final String email;
  final String photoURL;
  final String id;

 const User({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoURL,
  });

  static const User empty = User(id: "", displayName: "", email: "", photoURL: "");

  @override
  List<Object?> get props => [id,displayName, email, photoURL];

  Map<String, dynamic> toDocument() {
    return {
      "id": id,
      "displayName": displayName,
      "email": email,
      "photoURL": photoURL,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map;
    return User(
      id: doc.id,
      displayName: data["displayName"] ?? "",
      email: data["email"] ?? "",
      photoURL: data["photoURL"] ?? "",
    );
  }

  User copyWith({
    String? displayName,
    String? email,
    String? photoURL,
    String? id,
  }) {
    return User(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      id: id ?? this.id,
    );
  }
}
