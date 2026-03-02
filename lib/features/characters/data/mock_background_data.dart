import '../models/background.dart';

final Map<String, CharacterBackground> advancedBackgroundDatabase = {
  'Acolyte': const CharacterBackground(
    name: 'Acolyte',
    description:
        'You devote yourself to service in a temple, either nestled in a town or secluded in a sacred grove. There you perform sacred rites in honor of a god or pantheon.',
  ),
  'Criminal': const CharacterBackground(
    name: 'Criminal',
    description:
        'You learned to earn your coin in dark alleys, cutting purses or burgling shops. Perhaps you were part of a small gang of like-minded wrongdoers.',
  ),
  'Sage': const CharacterBackground(
    name: 'Sage',
    description:
        'You spent your formative years traveling between manors and monasteries, performing various odd jobs and services in exchange for access to their libraries.',
  ),
  'Soldier': const CharacterBackground(
    name: 'Soldier',
    description:
        'You trained as a warrior, learning to fight alongside others and enduring the grueling discipline of military life. You might have been part of a national army or a mercenary company.',
  ),
  // The UI will handle 'Custom' manually!
};
