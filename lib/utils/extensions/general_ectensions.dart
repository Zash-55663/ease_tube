import 'package:flutter/material.dart';

// Extension to simplify access to screen dimensions via BuildContext
extension MediaQueryValues on BuildContext {
  // Returns the total height of the screen (e.g., used for full-screen containers)
  double get mediaQueryHeight => MediaQuery.sizeOf(this).height;

  // Returns the total width of the screen (e.g., used for responsive button widths)
  double get mediaQueryWidth => MediaQuery.sizeOf(this).width;
}

// Extension on numeric types to quickly generate spacing widgets
extension EmptySpace on num {
  // Usage: 20.height returns a SizedBox with height: 20.0
  SizedBox get height => SizedBox(height: toDouble());

  // Usage: 10.width returns a SizedBox with width: 10.0
  SizedBox get width => SizedBox(width: toDouble());
}
