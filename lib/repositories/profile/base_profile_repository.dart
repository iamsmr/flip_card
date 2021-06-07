import 'package:flash_card/models/user.dart';

abstract class BaseProfileRepository {
  Future<User> getUserWithId({required String userId});
  Future<void> updateUser({required User user});
}
