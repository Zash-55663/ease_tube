import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
              'assets/images/user_profile.png',
            ), // Placeholder for user profile image
          ),
          SizedBox(height: 20),
          Text(
            'John Doe', // Placeholder for user name
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'john.doe@example.com', // Placeholder for user email
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
