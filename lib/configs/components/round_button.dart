import '../colors/app_colors.dart';
import '../components/loading_widget.dart';
import 'package:flutter/material.dart';

// A standardized button widget with built-in loading state management
class RoundButton extends StatelessWidget {
  final String title; // The text displayed on the button
  final bool loading; // Controls whether to show the text or a loading spinner
  final VoidCallback onPress; // The function executed when the button is tapped

  const RoundButton({
    super.key,
    required this.title,
    this.loading = false,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Center(
        child: loading
            // Displays a custom spinner (likely a CircularProgressIndicator) during API calls
            ? const LoadingWidget()
            // Displays the button title using standardized project colors when idle
            : Text(title, style: const TextStyle(color: AppColors.textButton)),
      ),
    );
  }
}
