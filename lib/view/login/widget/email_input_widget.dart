import 'package:ease_tube/utils/extensions/validations_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../configs/colors/app_colors.dart';

// A modular input field specifically for email entry, integrated with the LoginBloc
class EmailInputWidget extends StatefulWidget {
  const EmailInputWidget({super.key});

  @override
  State<EmailInputWidget> createState() => _EmailInputWidgetState();
}

class _EmailInputWidgetState extends State<EmailInputWidget> {
  // FocusNode and Controller to manage the lifecycle and interaction of the text field
  final FocusNode focusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // Standard cleanup to prevent memory leaks when the widget is destroyed
    focusNode.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      // Set to false because this widget's UI doesn't need to rebuild based on state changes
      buildWhen: (current, previous) => false,
      builder: (context, state) {
        return TextFormField(
          controller: emailController,
          focusNode: focusNode,
          // Optimizes the virtual keyboard for email entry (shows the '@' and '.' keys)
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'john@gmail.com',
            // Consistent rounded styling across the Ease'TUBE login form
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
          ),
          // Updates the LoginBloc with the current input for eventual API submission
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter email';
            }
            // Uses your custom extension to check for valid email formatting
            if (!value.emailValidator()) {
              return 'Email is not correct';
            }
            return null;
          },
          // Moves focus to the password field automatically when "Next" is pressed
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
