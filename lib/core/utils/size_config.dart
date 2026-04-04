/// Responsive sizing utilities for consistent UI scaling across devices.
///
/// This file provides the [SizeConfig] class for responsive layout calculations.
/// It normalizes widget sizes based on a reference design (375x810) to ensure
/// consistent proportions across different Android screen sizes.
///
/// Usage:
/// ```dart
/// // Initialize once in the root widget
/// SizeConfig().init(context);
///
/// // Use in widgets for responsive sizing
/// Container(
///   width: SizeConfig.w(100),  // 100dp from the design
///   height: SizeConfig.h(50),  // 50dp from the design
/// )
/// ```
library;

import 'package:flutter/material.dart';

/// Utility class for responsive sizing calculations.
///
/// Provides methods to convert design dimensions (from Figma/XD) to
/// runtime dimensions that scale proportionally across different screen sizes.
///
/// The design is based on a reference device with:
/// - Width: 375dp (similar to iPhone 12 / standard Android phone)
/// - Height: 810dp
///
/// All sizing methods are static after initialization for convenient access
/// throughout the app without passing context.
class SizeConfig {
  static late MediaQueryData _mediaQueryData;

  /// Current device screen width in pixels.
  static late double screenWidth;

  /// Current device screen height in pixels.
  static late double screenHeight;

  /// Width of 1% of screen (screenWidth / 100).
  static late double blockWidth;

  /// Height of 1% of screen (screenHeight / 100).
  static late double blockHeight;

  /// Reference design width in dp (375dp).
  ///
  /// This is the base width used in the UI design files.
  static const double designWidth = 375;

  /// Reference design height in dp (810dp).
  ///
  /// This is the base height used in the UI design files.
  static const double designHeight = 810;

  /// Initializes the size configuration with the current screen dimensions.
  ///
  /// Must be called once in the root widget's build method before using
  /// any of the sizing methods.
  ///
  /// [context] - The build context with access to MediaQuery.
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }

  /// Converts a design width value to proportional screen width.
  ///
  /// Takes a width from the design file and scales it proportionally
  /// to the current device's screen width.
  ///
  /// Example:
  /// ```dart
  /// // If design shows 100dp width, use:
  /// SizeConfig.w(100)
  /// // On a 375dp screen: returns 100
  /// // On a 750dp screen: returns 200
  /// ```
  ///
  /// [inputWidth] - Width value from the design file in dp.
  /// Returns the scaled width for the current device.
  static double w(double inputWidth) =>
      (inputWidth / designWidth) * screenWidth;

  /// Converts a design height value to proportional screen height.
  ///
  /// Takes a height from the design file and scales it proportionally
  /// to the current device's screen height.
  ///
  /// Example:
  /// ```dart
  /// // If design shows 50dp height, use:
  /// SizeConfig.h(50)
  /// // On a 810dp screen: returns 50
  /// // On a 1620dp screen: returns 100
  /// ```
  ///
  /// [inputHeight] - Height value from the design file in dp.
  /// Returns the scaled height for the current device.
  static double h(double inputHeight) =>
      (inputHeight / designHeight) * screenHeight;
}