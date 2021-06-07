import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_card/config/paths.dart';
import 'package:flash_card/models/decks.dart';
import 'package:flash_card/repositories/repositories.dart';

class DecksRepository extends BaseDecksRepositry {
  final FirebaseFirestore _firebaseFirestore;

  DecksRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createDecks({required Decks decks}) async {
    await _firebaseFirestore.collection(Paths.decks).add(decks.toDocument());
  }

  @override
  Stream<List<Future<Decks?>>> getDecks({required String userId}) {
    final creatorRef = _firebaseFirestore.collection(Paths.users).doc(userId);
    return _firebaseFirestore
        .collection(Paths.decks)
        .where("creator", isEqualTo: creatorRef)
        .orderBy("date", descending: false)
        .snapshots()
        .map(
      (snap) {
        return snap.docs.map((doc) {
          return Decks.fromDocument(doc);
        }).toList();
      },
    );
  }
}
