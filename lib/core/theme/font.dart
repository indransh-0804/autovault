/// Custom text theme configuration using Google Fonts.
///
/// This file provides a utility function to create a mixed text theme combining
/// two different fonts:
/// - Display text (headlines, titles): One font family
/// - Body text (paragraphs, labels): Another font family
///
/// The app uses Manrope for body text and Inter for display text.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Creates a custom text theme with separate fonts for display and body text.
///
/// This function combines two Google Fonts families into a single [TextTheme]:
/// - **Display styles** (displayLarge, displayMedium, etc.) use [displayFontString]
/// - **Body styles** (bodyLarge, bodyMedium, bodySmall) use [bodyFontString]
/// - **Label styles** (labelLarge, labelMedium, labelSmall) use [bodyFontString]
///
/// This creates visual hierarchy and distinction between headings and content.
///
/// Example usage:
/// ```dart
/// TextTheme textTheme = createTextTheme(context, "Manrope", "Inter");
/// ```
///
/// In AutoVault:
/// - Manrope: Used for body text, buttons, form labels (clean, readable)
/// - Inter: Used for titles, headers, app bar text (strong, distinctive)
///
/// [context] - Build context for accessing the default theme.
/// [bodyFontString] - Google Fonts family name for body/label text.
/// [displayFontString] - Google Fonts family name for display/heading text.
///
/// Returns a complete [TextTheme] with the custom font configuration.
TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  // Get the base text theme from current context
  TextTheme baseTextTheme = Theme.of(context).textTheme;

  // Create body text theme using the specified body font
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );

  // Create display text theme using the specified display font
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );

  // Merge: Keep display styles from displayTextTheme,
  // override body/label styles with bodyTextTheme
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );

  return textTheme;
}