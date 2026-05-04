import 'package:ease_tube/configs/components/round_button.dart';
import 'package:ease_tube/utils/extensions/flush_bar_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../configs/routes/routes_name.dart';
import '../../../data/response/status.dart';

// A specialized button that handles form submission and authentication state changes
class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const SubmitButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    // BlocConsumer combines a listener for side effects and a builder for UI updates
    return BlocConsumer<LoginBloc, LoginStates>(
      listenWhen: (current, previous) =>
          current.loginApi.status != previous.loginApi.status,
      listener: (context, state) {
        // Displays an error message if the authentication fails
        if (state.loginApi.status == Status.error) {
          context.showFlushBar(message: state.loginApi.message.toString());
        }

        // Redirects to the Home Screen and clears navigation history upon successful login
        if (state.loginApi.status == Status.completed) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.home,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          // Sets button width to 30% of the screen width for a centered, compact look
          width: MediaQuery.of(context).size.width * 0.3,
          child: RoundButton(
            title: 'Login',
            // Shows a loading spinner automatically when the API status is 'loading'
            loading: state.loginApi.status == Status.loading,
            onPress: () {
              // Validates all form fields before triggering the login event
              if (formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(const LoginApi());
              }
            },
          ),
        );
      },
    );
  }
}
