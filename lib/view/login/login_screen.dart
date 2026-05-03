import 'package:ease_tube/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login_bloc/login_bloc.dart';

import '../../dependency_injection/locator.dart';
import 'widget/widgets.dart'; // Importing custom widget components

/// A widget representing the login screen of the application.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// The state of the [LoginScreen] widget.
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<LoginBloc>(),
        child: BlocListener<LoginBloc, LoginStates>(
          // Add this listener
          listener: (context, state) {
            // Check if the API response status is COMPLETED (Success)
            if (state.loginApi.status == Status.completed) {
              debugPrint("Login Successful! Navigating...");
              // Navigator.pushReplacementNamed(context, '/home');
            }
            // Check if the API response status is ERROR (Failure)
            else if (state.loginApi.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.loginApi.message ?? 'Login Failed'),
                ),
              );
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 40),
                      Image.asset(
                        'assets/images/splash.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      const SizedBox(height: 30),
                      const EmailInputWidget(),
                      const SizedBox(height: 20),
                      const PasswordInputWidget(),
                      const SizedBox(height: 20),
                      // Use BlocBuilder here if you want to show a loading spinner on the button
                      SubmitButton(formKey: _formKey),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
