import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_card/config/paths.dart';
import 'package:flash_card/models/user.dart';
import 'package:flash_card/repositories/repositories.dart';

class ProfileRepository extends BaseProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProfileRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<User> getUserWithId({required String userId}) async {
    final doc =
        await _firebaseFirestore.collection(Paths.users).doc(userId).get();
    return doc.exists ? User.fromDocument(doc) : User.empty;
  }

  @override
  Future<void> updateUser({required User user}) async {
    await _firebaseFirestore
        .collection(Paths.users)
        .doc(user.id)
        .update(user.toDocument());
  }
}
