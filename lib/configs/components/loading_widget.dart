import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Adaptive loading indicator that matches the host operating system
class LoadingWidget extends StatelessWidget {
  final double size;
  const LoadingWidget({super.key, this.size = 36.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Platform.isIOS
            // Renders the standard Apple-style spinner for your iPhone Xs
            ? const CupertinoActivityIndicator()
            // Renders the Material Design spinner for your itel hardware
            : const CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.blue,
              ),
      ),
    );
  }
}
