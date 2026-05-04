import 'package:flutter/material.dart';

/// A widget that displays a user-friendly error message when a [NoInternetException] occurs.
/// It provides a retry button to re-trigger the failed network request.
class InterNetExceptionWidget extends StatefulWidget {
  // Callback function to be executed when the 'RETRY' button is pressed.
  final VoidCallback onPress;

  const InterNetExceptionWidget({super.key, required this.onPress});

  @override
  State<InterNetExceptionWidget> createState() =>
      _InterNetExceptionWidgetState();
}

class _InterNetExceptionWidgetState extends State<InterNetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    // Dynamic height calculation for consistent spacing across different screen sizes
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Ensures content is centered vertically
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top spacing to push content toward the center
          SizedBox(height: screenHeight * .15),

          // Visual indicator for connectivity loss
          const Icon(Icons.cloud_off, color: Colors.red, size: 50),

          // Descriptive error message for the user
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              'We’re unable to show results.\nPlease check your data\nconnection.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontSize: 20),
            ),
          ),

          // Spacing between the message and the action button
          SizedBox(height: screenHeight * .1),

          // Retry button to allow the user to attempt the operation again
          SizedBox(
            height: 44, // Standard touch target height
            width: 160, // Fixed width for a consistent look
            child: ElevatedButton(
              onPressed: widget.onPress,
              child: Text(
                'RETRY',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),

          // Bottom spacing for layout balance
          SizedBox(height: screenHeight * .1),
        ],
      ),
    );
  }
}
