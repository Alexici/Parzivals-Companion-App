import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_companion/features/characters/models/character.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final characterRepositoryProvider = Provider<CharacterRepository>((ref) {
  return CharacterRepository(FirebaseFirestore.instance);
});

class CharacterRepository {
  final FirebaseFirestore _firestore;

  CharacterRepository(this._firestore);

  CollectionReference get _characters => _firestore.collection('characters');

  // Create a new character in Firestore
  Future<void> createCharacter(Character character) async {
    try {
      await _characters.doc(character.id).set(character.toMap());
    } catch (e) {
      throw Exception("Failed to create character: $e");
    }
  }

  // Stream all characters belonging to the logged-in user
  Stream<List<Character>> getUserCharacters(String userId) {
    return _characters.where('ownerId', isEqualTo: userId).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs
          .map(
            (doc) =>
                Character.fromMap(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList();
    });
  }
}
