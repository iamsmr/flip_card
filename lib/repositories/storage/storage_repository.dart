import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flash_card/repositories/storage/base_storage_repository.dart';
import 'package:uuid/uuid.dart';

class StorageRepository extends BaseStorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({FirebaseStorage? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> _uploadImage({
    required File image,
    required String ref,
  }) async {
    final downloadUrl = await _firebaseStorage
        .ref(ref)
        .putFile(image)
        .then((taskSnap) => taskSnap.ref.getDownloadURL());

    return downloadUrl;
  }

  @override
  Future<String> uploadProfileImage({
    required String? url,
    required File image,
  }) async {
    var imageId = Uuid().v4();

    if (url != null && url.isNotEmpty && !url.contains("googleusercontent")) {
      final exp = RegExp(r'userProfile_(.*).jpg');
      imageId = exp.firstMatch(url)![1]!;
    }

    final downloadUrl = await _uploadImage(
      image: image,
      ref: "images/users/userProfile_$imageId.jpg",
    );
    return downloadUrl;
  }
}
