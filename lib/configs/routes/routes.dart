import 'package:ease_tube/configs/routes/routes_name.dart';

import 'package:flutter/material.dart';

import '../../view/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );

      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        );
      case RoutesName.userProfile:
        return MaterialPageRoute(
          builder: (BuildContext context) => const UserProfileScreen(),
        );

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
