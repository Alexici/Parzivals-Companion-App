import 'package:dnd_companion/features/characters/models/character.dart';
import 'package:dnd_companion/features/characters/repositories/character_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';

// Real-time stream of characters for the logged-in user
final userCharactersProvider = StreamProvider<List<Character>>((ref) {
  final authState = ref.watch(authStateProvider);
  final user = authState.value;

  if (user == null) return Stream.value([]);

  final repository = ref.watch(characterRepositoryProvider);

  return repository.getUserCharacters(user.uid);
});
