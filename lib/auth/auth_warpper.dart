import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../view/view.dart';

/// A widget that manages the high-level navigation flow based on the user's session.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Listens to the real-time authentication state from Firebase
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. Initial State: While checking for an existing session on app startup
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              // Using AppColors.primary (0xFFA8D0B4) for consistency
              child: CircularProgressIndicator(color: Color(0xFFA8D0B4)),
            ),
          );
        }

        // 2. Authenticated State: A valid user session exists
        if (snapshot.hasData) {
          return const HomeScreen(); // Directs to the main video feed
        }

        // 3. Unauthenticated State: No user is logged in
        return const LoginScreen(); // Directs to the credentials entry screen
      },
    );
  }
}
