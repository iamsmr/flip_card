import 'package:flash_card/models/decks.dart';

abstract class BaseDecksRepositry {
  Future<void> createDecks({required Decks decks});

  Stream<List<Future<Decks?>>> getDecks({required String userId});
}
