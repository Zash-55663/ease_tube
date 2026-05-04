import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

// Extension for handling error notifications, specifically tuned to prevent overflow
extension FlushBarErrorMessage on BuildContext {
  void showFlushBar({required String message}) {
    Flushbar(
      // Uses messageText to apply a maxLines constraint, solving potential pixel overflows
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      duration: const Duration(seconds: 4),
      // Positioned at the top to remain visible even when the keyboard is open on your iPhone Xs
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.redAccent,
    ).show(this);
  }
}

// Extension for handling successful operation feedback
extension FlushBarSuccessMessage on BuildContext {
  void flushBarSuccessMessage({required String message}) {
    showFlushbar(
      context: this,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green, // Standard success green
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons
              .check_circle, // Suggestion: changed from error to check_circle for success
          size: 28,
          color: Colors.white,
        ),
      )..show(this),
    );
  }
}
