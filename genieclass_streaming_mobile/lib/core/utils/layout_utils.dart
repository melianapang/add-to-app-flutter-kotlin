import 'package:flutter/material.dart';

class LayoutUtils {
  static bool isTablet(context) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    double shortestSide = MediaQuery.of(context).size.shortestSide;

    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    return shortestSide >= 600;
  }
}
