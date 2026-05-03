import 'package:ease_tube/configs/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../configs/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Image.asset(
          'assets/images/splash.png',
          height: 32,
        ), // Displaying the logo in the app bar
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: InkWell(
              child: Icon(Icons.account_circle, size: 28),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesName.userProfile,
                ); // Navigate to user profile screen
              },
            ),
          ),
        ],
      ),
    );
  }
}
