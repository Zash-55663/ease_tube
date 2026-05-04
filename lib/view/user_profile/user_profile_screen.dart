import 'package:ease_tube/configs/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Displays personal account details and provides logout functionality
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieves the currently authenticated user from Firebase
    final user = FirebaseAuth.instance.currentUser;

    // Fallback logic for guests or if the session is lost
    final String email = user?.email ?? 'Not Logged In';

    // Extracts a display name from the email (e.g., "zamad" from "zamad@gmail.com")
    final String username = email.contains('@') ? email.split('@')[0] : 'User';

    return Scaffold(
      appBar: AppBar(title: const Text('User Profile'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // User avatar display using a local asset placeholder
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user_profile.png'),
            ),
            const SizedBox(height: 20),

            // Displays the parsed username in a bold headline style
            Text(
              username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Displays the complete email address for account verification
            Text(
              email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Logout action to terminate the Firebase session
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () async {
                // 1. Sign out from the Firebase backend
                await FirebaseAuth.instance.signOut();

                // 2. Clear the navigation stack and go to the Splash or AuthWrapper
                // This ensures the StreamBuilder in AuthWrapper catches the 'null' user state
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesName.splash, // Or use your initial entry route
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
