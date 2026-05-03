import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../view/view.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // This stream listens to Firebase Auth changes (login/logout/app start)
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. If the connection is still loading, show a loading spinner
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFA8D0B4)),
            ),
          );
        }

        // 2. If snapshot has data, the user is logged in
        if (snapshot.hasData) {
          return const HomeScreen(); // Your Ease tube Home Feed
        }

        // 3. Otherwise, the user is NOT logged in
        return const LoginScreen();
      },
    );
  }
}
