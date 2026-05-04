import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../configs/colors/app_colors.dart';

// A modular password field that integrates with LoginBloc for visibility and state management
class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({super.key});

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  // FocusNode and Controller to manage the lifecycle of the text input
  final FocusNode focusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Ensuring resources are released when the widget is removed from the tree
    focusNode.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      // Only rebuilds this widget when the password visibility state changes
      buildWhen: (current, previous) =>
          previous.isPasswordVisible != current.isPasswordVisible,
      builder: (context, state) {
        return TextFormField(
          controller: passwordController,
          focusNode: focusNode,
          // Hides or shows text based on the BLoC state
          obscureText: !state.isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            // Toggle button to switch between showing and hiding the password
            suffixIcon: IconButton(
              onPressed: () {
                context.read<LoginBloc>().add(TogglePasswordVisibility());
              },
              icon: Icon(
                state.isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 23,
              ),
            ),
            // Consistent rounded border styling using the Ease'TUBE primary color
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 3, color: AppColors.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 3, color: AppColors.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 3, color: AppColors.primary),
            ),
            helperText:
                'Password should be at least 6 characters with at least one letter and number',
            helperMaxLines: 2,
            errorMaxLines: 2,
          ),
          // Basic validation logic for the form key in LoginScreen
          validator: (value) {
            if (value == null || value.isEmpty) return 'Enter password';
            if (value.length < 6) return 'Password must be > 6 chars';
            return null;
          },
          // Updates the BLoC state on every keystroke
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}
