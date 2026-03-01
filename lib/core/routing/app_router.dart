import 'package:dnd_companion/features/characters/screens/character_creation_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Auth Provider
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/campaigns/screens/campaigns_screen.dart';
import '../../features/characters/screens/characters_screen.dart';
// Dashboard & Tabs
import '../../features/dashboard/screens/foyer_shell.dart';
import '../../features/profile/screens/profile_screens.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/characters',

    // Redirect Logic
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);

      if (authState.isLoading || authState.hasError) return null;

      final isAuth = authState.value != null; // Safely check for user
      final isGoingToLogin = state.uri.path == '/login';

      // Kick to login if not authenticated
      if (!isAuth && !isGoingToLogin) {
        return '/login';
      }
      // Push to dashboard if they are already logged in
      if (isAuth && isGoingToLogin) {
        return '/characters';
      }

      return null;
    },

    // THE ROUTES
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/create-character',
        builder: (context, state) => const CharacterCreationScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return FoyerShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/characters',
                builder: (context, state) => const CharactersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/campaigns',
                builder: (context, state) => const CampaignsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  // Listen to auth state changes and refresh the router
  ref.listen(authStateProvider, (previous, next) {
    router.refresh();
  });

  return router;
});
