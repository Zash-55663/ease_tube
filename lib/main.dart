// Importing necessary packages and files
import 'package:firebase_core/firebase_core.dart';
import 'package:ease_tube/view/home/home_screen.dart';
import 'package:ease_tube/view/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'configs/routes/routes.dart'; // Custom routes
// import 'configs/routes/routes_name.dart'; // Route names
import 'dependency_injection/locator.dart'; // Light theme configuration

ServiceLocator dependencyInjector = ServiceLocator();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensuring that Flutter bindings are initialized
  await Firebase.initializeApp();
  dependencyInjector
      .servicesLocator(); // Initializing service locator for dependency injection

  runApp(const MyApp()); // Running the application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp widget

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Material app configuration
      // title: 'Flutter Demo',
      // themeMode: ThemeMode.dark, // Setting theme mode to dark
      // theme: lightTheme, // Setting light theme
      // darkTheme: darkTheme, // Setting dark theme
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en'), // English locale
      //   Locale('es'), // Spanish locale
      // ],
      // initialRoute: RoutesName.splash, // Initial route
      // onGenerateRoute: Routes.generateRoute, // Generating routes
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // If Firebase is checking session
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // If user is logged in, show Home
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // Otherwise, show Login
          return const LoginScreen();
        },
      ),
    );
  }
}
