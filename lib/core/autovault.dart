/// Re-export of core application components.
///
/// This file serves as a barrel file, consolidating imports from core modules
/// for easier access throughout the application. Instead of importing from
/// multiple files, other parts of the app can import from this single file.
///
/// Exports:
/// - Theme configuration (fonts, colors, Material 3 themes)
/// - Routing configuration (GoRouter setup)
/// - Utility classes (responsive sizing)
/// - Root application widget
library;

import 'package:autovault/core/theme/font.dart';
import 'package:autovault/core/theme/theme.dart';
import 'package:autovault/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:autovault/core/app/route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Root widget for the AutoVault application.
///
/// This widget sets up:
/// - Material 3 theming with custom color schemes (light/dark)
/// - Custom text themes using Manrope and Inter fonts
/// - GoRouter-based navigation with auth-aware redirects
/// - Responsive sizing via [SizeConfig]
///
/// The widget is a [ConsumerWidget] to access Riverpod providers for
/// router configuration and authentication state.
class AutoVault extends ConsumerWidget {
  /// Creates the AutoVault root widget.
  const AutoVault({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the router provider for reactive navigation updates
    final router = ref.watch(goRouterProvider);

    // Determine system brightness for automatic theme switching
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Create custom text theme with Manrope (body) and Inter (display) fonts
    TextTheme textTheme = createTextTheme(context, "Manrope", "Inter");

    // Initialize Material 3 theme with custom color schemes
    MaterialTheme theme = MaterialTheme(textTheme);

    // Initialize responsive sizing configuration
    SizeConfig().init(context);

    return MaterialApp.router(
      routerConfig: router,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      debugShowCheckedModeBanner: false,
      title: 'AutoVault',
    );
  }
}
