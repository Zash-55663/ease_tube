// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../configs/colors/app_colors.dart';
import '../../configs/routes/routes_name.dart';

// The initial screen that handles branding and session validation
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start the authentication check immediately upon screen creation
    _checkAuth();
  }

  // Determines if the user should proceed to the Home or Login screen
  void _checkAuth() async {
    // Artificial delay to ensure the brand logo is visible to the user
    await Future.delayed(const Duration(seconds: 3));

    // Persisted Firebase session check
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Navigate to Home Screen if a valid user session is found
      Navigator.pushReplacementNamed(context, RoutesName.home);
    } else {
      // Redirect to Login Screen if no user is authenticated
      Navigator.pushReplacementNamed(context, RoutesName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Uses the global brand background color defined in AppColors
      backgroundColor: AppColors.background,
      body: Center(
        // Displays the Ease'TUBE logo centered on the iPhone Xs screen
        child: Image.asset('assets/images/splash.png'),
      ),
    );
  }
}
