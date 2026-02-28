import 'package:dnd_companion/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/providers/auth_provider.dart';

class DnDCompanionApp extends ConsumerWidget {
  const DnDCompanionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Parzival\'s Dice Tavern',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: authState.when(
            data: (user) {
              if (user != null) {
                return Text('Welcome, ${user.email}');
              } else {
                return const LoginScreen();
              }
            },
            error: (error, stack) => Text('Error: $error'),
            loading: () => CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
