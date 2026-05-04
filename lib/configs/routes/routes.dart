import 'package:ease_tube/configs/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../view/view.dart';

// Central class for managing application navigation and screen transitions
class Routes {
  // Logic to determine which screen to build based on the provided RouteSettings
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Directs the user to the initial landing/loading screen
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );

      // Handles navigation to the authentication portal
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        );

      // Routes to the main video feed dashboard
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );

      // Directs to the personal account and settings area
      case RoutesName.userProfile:
        return MaterialPageRoute(
          builder: (BuildContext context) => const UserProfileScreen(),
        );

      // Fallback case to prevent the app from crashing if an undefined route is called
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text('No route defined')),
            );
          },
        );
    }
  }
}
