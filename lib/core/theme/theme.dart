/// Material 3 theme configuration for AutoVault.
///
/// This file defines the complete color schemes and theme data for both
/// light and dark modes using Material Design 3 principles.
///
/// The theme includes:
/// - **Light and dark color schemes** with comprehensive role definitions
/// - **Extended colors** for custom brand colors
/// - **Gradient definitions** for dashboard KPI cards
///
/// Color scheme structure follows Material 3 token system:
/// - Primary: Main brand color (blue shades)
/// - Secondary: Supporting color for less prominent elements
/// - Tertiary: Accent color for highlights and special elements
/// - Error: For error states and destructive actions
/// - Surface: Background colors for cards and elevated components
///
/// All colors are defined as hex values and automatically adapt based on
/// brightness (light/dark mode).
library;

import 'package:flutter/material.dart';

/// Main theme configuration class for AutoVault.
///
/// Provides factory methods for creating light and dark [ThemeData] instances
/// with custom color schemes. Takes a [TextTheme] as input to apply custom
/// fonts from the font.dart configuration.
///
/// Usage:
/// ```dart
/// TextTheme textTheme = createTextTheme(context, "Manrope", "Inter");
/// MaterialTheme theme = MaterialTheme(textTheme);
/// ThemeData lightTheme = theme.light();
/// ThemeData darkTheme = theme.dark();
/// ```
class MaterialTheme {
  /// Custom text theme with font configuration.
  final TextTheme textTheme;

  /// Creates a MaterialTheme with the given text theme.
  const MaterialTheme(this.textTheme);

  /// Returns the light mode color scheme.
  ///
  /// Based on Material 3 color system with a blue primary color.
  /// Used during daytime or when the user prefers light mode.
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff415f91),
      surfaceTint: Color(0xff415f91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd6e3ff),
      onPrimaryContainer: Color(0xff284777),
      secondary: Color(0xff565f71),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdae2f9),
      onSecondaryContainer: Color(0xff3e4759),
      tertiary: Color(0xff705575),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfffad8fd),
      onTertiaryContainer: Color(0xff573e5c),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff191c20),
      onSurfaceVariant: Color(0xff44474e),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc4c6d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3036),
      inversePrimary: Color(0xffaac7ff),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff001b3e),
      primaryFixedDim: Color(0xffaac7ff),
      onPrimaryFixedVariant: Color(0xff284777),
      secondaryFixed: Color(0xffdae2f9),
      onSecondaryFixed: Color(0xff131c2b),
      secondaryFixedDim: Color(0xffbec6dc),
      onSecondaryFixedVariant: Color(0xff3e4759),
      tertiaryFixed: Color(0xfffad8fd),
      onTertiaryFixed: Color(0xff28132e),
      tertiaryFixedDim: Color(0xffddbce0),
      onTertiaryFixedVariant: Color(0xff573e5c),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe7e8ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  /// Returns the dark mode color scheme.
  ///
  /// Based on Material 3 color system with adjusted colors for dark backgrounds.
  /// Used during nighttime or when the user prefers dark mode.
  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffaac7ff),
      surfaceTint: Color(0xffaac7ff),
      onPrimary: Color(0xff0a305f),
      primaryContainer: Color(0xff284777),
      onPrimaryContainer: Color(0xffd6e3ff),
      secondary: Color(0xffbec6dc),
      onSecondary: Color(0xff283141),
      secondaryContainer: Color(0xff3e4759),
      onSecondaryContainer: Color(0xffdae2f9),
      tertiary: Color(0xffddbce0),
      onTertiary: Color(0xff3f2844),
      tertiaryContainer: Color(0xff573e5c),
      onTertiaryContainer: Color(0xfffad8fd),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111318),
      onSurface: Color(0xffe2e2e9),
      onSurfaceVariant: Color(0xffc4c6d0),
      outline: Color(0xff8e9099),
      outlineVariant: Color(0xff44474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff415f91),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff001b3e),
      primaryFixedDim: Color(0xffaac7ff),
      onPrimaryFixedVariant: Color(0xff284777),
      secondaryFixed: Color(0xffdae2f9),
      onSecondaryFixed: Color(0xff131c2b),
      secondaryFixedDim: Color(0xffbec6dc),
      onSecondaryFixedVariant: Color(0xff3e4759),
      tertiaryFixed: Color(0xfffad8fd),
      onTertiaryFixed: Color(0xff28132e),
      tertiaryFixedDim: Color(0xffddbce0),
      onTertiaryFixedVariant: Color(0xff573e5c),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  /// Creates a complete light theme with the light color scheme.
  ThemeData light() => theme(lightScheme());

  /// Creates a complete dark theme with the dark color scheme.
  ThemeData dark() => theme(darkScheme());

  /// Builds a complete [ThemeData] from a [ColorScheme].
  ///
  /// Applies:
  /// - Material 3 design system
  /// - Custom text theme with fonts
  /// - Surface colors for scaffolds and canvas
  /// - Color-matched text colors
  ///
  /// [colorScheme] - The color scheme to apply (light or dark).
  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
      );

  /// Extended custom colors for brand-specific use cases.
  ///
  /// Currently empty but can be used to define additional color families
  /// beyond the standard Material 3 primary/secondary/tertiary system.
  List<ExtendedColor> get extendedColors => [];
}

/// Represents an extended color family for custom brand colors.
///
/// Provides light and dark variants of a custom color for use throughout
/// the app while maintaining Material 3 color system principles.
class ExtendedColor {
  /// The seed color used to generate the color family.
  final Color seed;

  /// The primary color value.
  final Color value;

  /// Light mode color family variant.
  final ColorFamily light;

  /// Dark mode color family variant.
  final ColorFamily dark;

  /// Creates an extended color with light and dark variants.
  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.dark,
  });
}

/// A family of four related colors following Material 3 color roles.
///
/// Provides the standard Material 3 color roles:
/// - color: The main color
/// - onColor: Text/icon color to use on top of [color]
/// - colorContainer: A lighter variant for containers
/// - onColorContainer: Text/icon color to use on top of [colorContainer]
class ColorFamily {
  /// The main color of this family.
  final Color color;

  /// Color for text/icons on top of [color].
  final Color onColor;

  /// A lighter container variant of [color].
  final Color colorContainer;

  /// Color for text/icons on top of [colorContainer].
  final Color onColorContainer;

  /// Creates a color family with four related colors.
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });
}

/// Custom application colors for gradients and special UI elements.
///
/// Defines gradient color stops used in dashboard KPI cards to create
/// visually distinctive backgrounds for different metric types.
///
/// All gradients use semi-transparent blue-teal combinations for a
/// modern, professional appearance.
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  /// Gradient for revenue/earnings KPI cards.
  ///
  /// Blue-to-teal-to-blue gradient with 47% opacity.
  /// Used in owner dashboard for total revenue metrics.
  static const List<Color> revenueGradient = [
    Color(0x7777A1D3),
    Color(0x7779CBCA),
    Color(0x7777A1D3),
  ];

  /// Gradient for sales count KPI cards.
  ///
  /// Teal-to-blue-to-teal gradient with 47% opacity.
  /// Used in dashboards for sales count and conversion metrics.
  static const List<Color> salesGradient = [
    Color(0x7779CBCA),
    Color(0x7777A1D3),
    Color(0x7779CBCA),
  ];

  /// Gradient for active loans KPI cards.
  ///
  /// Blue-to-teal-to-blue gradient with 47% opacity.
  /// Used in loan overview sections and financing metrics.
  static const List<Color> loansGradient = [
    Color(0x7777A1D3),
    Color(0x7779CBCA),
    Color(0x7777A1D3),
  ];

  /// Gradient for test drive KPI cards.
  ///
  /// Teal-to-blue-to-teal gradient with 47% opacity.
  /// Used in test drive scheduling and tracking widgets.
  static const List<Color> testDriveGradient = [
    Color(0x7779CBCA),
    Color(0x7777A1D3),
    Color(0x7779CBCA),
  ];
}
