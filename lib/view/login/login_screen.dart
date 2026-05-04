// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import '../../dependency_injection/locator.dart';
import 'widget/widgets.dart';

// The entry point for user authentication using the BLoC pattern
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBlocs;

  // Key used to validate the email and password form fields
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Injects the LoginBloc instance from the Service Locator (GetIt)
    _loginBlocs = getIt<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        // Provides the LoginBloc to the widget tree for state management
        create: (_) => _loginBlocs,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Branding logo for the login interface
                Image.asset('assets/images/splash.png', height: 200),

                // Custom modular input components
                const EmailInputWidget(),
                const SizedBox(height: 20),
                const PasswordInputWidget(),
                const SizedBox(height: 20),

                // Button that triggers the LoginBloc events via form validation
                SubmitButton(formKey: _formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
