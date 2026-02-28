import 'package:dnd_companion/core/theme/app_colors.dart';
import 'package:dnd_companion/core/widgets/glass_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dnd_companion/core/utils/app_snackbars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Flag for obscuring password
  bool _isObscure = true;

  // Flag for Login/Register toggle
  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.midnightBlue,
              AppColors.royalPurple,
              AppColors.pitchBlack,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // The Title
                  Text(
                    "Parzival's Dice Tavern",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.medievalSharp(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        const Shadow(
                          blurRadius: 10.0,
                          color: Colors.deepPurpleAccent,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Container
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 500),
                    child: GlassContainer(
                      child: Column(
                        children: [
                          // Username Field (for registration only)
                          if (!_isLogin)
                            TextFormField(
                              controller: _usernameController,
                              style: GoogleFonts.inter(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: GoogleFonts.inter(
                                  color: Colors.white60,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white30),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              ),
                            ),
                          if (!_isLogin) const SizedBox(height: 20),
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            style: GoogleFonts.inter(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: GoogleFonts.inter(
                                color: Colors.white60,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white30),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            style: GoogleFonts.inter(color: Colors.white),
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: GoogleFonts.inter(
                                color: Colors.white60,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white30),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Confirm Password Field (for registration only)
                          if (!_isLogin)
                            TextFormField(
                              controller: _confirmPasswordController,
                              style: GoogleFonts.inter(color: Colors.white),
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: GoogleFonts.inter(
                                  color: Colors.white60,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white30),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                            ),
                          if (!_isLogin) const SizedBox(height: 20),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurpleAccent
                                    .withValues(alpha: 0.6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () async {
                                final email = _emailController.text.trim();
                                final password = _passwordController.text
                                    .trim();

                                // Core validation
                                if (email.isEmpty || password.isEmpty) {
                                  AppSnackbars.showError(
                                    'Please make sure to fill out all the fields!',
                                  );
                                  return;
                                }

                                // Registration-specific validation
                                // Check username
                                if (!_isLogin) {
                                  final username = _usernameController.text
                                      .trim();
                                  final confirmPassword =
                                      _confirmPasswordController.text.trim();

                                  if (username.isEmpty) {
                                    AppSnackbars.showError(
                                      'Please enter a username for your character!',
                                    );
                                    return;
                                  }

                                  // Check if passwords match
                                  if (password != confirmPassword) {
                                    AppSnackbars.showError(
                                      'Passwords do not match. Please try again.',
                                    );
                                    return;
                                  }
                                }
                                try {
                                  if (_isLogin) {
                                    // Login Logic
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );
                                  } else {
                                    // Register logic
                                    final userCredential = await FirebaseAuth
                                        .instance
                                        .createUserWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );

                                    // Grabbing the new user id
                                    final String newUid =
                                        userCredential.user!.uid;

                                    try {
                                      // Attempt to create the user profile
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(newUid)
                                          .set({
                                            'username': _usernameController.text
                                                .trim(),
                                            'email': email,
                                            'createdAt':
                                                FieldValue.serverTimestamp(),
                                          });
                                    } catch (dbError) {
                                      // If profile creation fails, delete the newly created auth user to prevent orphaned accounts
                                      await userCredential.user!.delete();
                                      AppSnackbars.showError(
                                        'You have been kicked out of the tavern for no reason! Please try registering again.',
                                      );
                                    }
                                  }
                                } on FirebaseAuthException catch (e) {
                                  AppSnackbars.showError(
                                    e.message ??
                                        'An error occurred. Please try again.',
                                  );
                                } catch (e) {
                                  AppSnackbars.showError(
                                    'An unexpected error occurred. Please try again.',
                                  );
                                }
                              },
                              child: Text(
                                _isLogin
                                    ? 'Enter the Tavern'
                                    : 'Forge Your Account',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin
                                  ? "New to the tavern? Register here!"
                                  : "Already a member? Login here!",
                              style: GoogleFonts.inter(
                                color: Colors.white70,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
