/// Main entry point for the AutoMobile car showroom management application.
///
/// This file initializes the Flutter app with:
/// - Firebase (Authentication, Firestore, Storage)
/// - Hive (local caching for offline support)
/// - Riverpod (state management)
///
/// The app follows a feature-first clean architecture with role-based access
/// control for showroom owners, employees, and suppliers.
library;

import 'package:autovault/core/autovault.dart';
import 'package:autovault/core/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Defines the Hive box names used for local data persistence.
///
/// Hive is used to cache authentication state and user data for offline support
/// and faster app startup.
class HiveBoxes {
  HiveBoxes._();

  /// Box name for authentication-related data (user profile, token, role).
  static const String auth = 'authBox';
}

/// Defines the keys used to store values in Hive boxes.
///
/// These keys map to specific pieces of authentication data stored locally.
class HiveKeys {
  HiveKeys._();

  /// Key for the current user's complete profile (JSON-serialized UserModel).
  static const String currentUser = 'currentUser';

  /// Key for the Firebase authentication token (Firebase UID).
  static const String authToken = 'authToken';

  /// Key for the current user's role (owner or employee).
  static const String userRole = 'userRole';
}

/// Application entry point.
///
/// Initializes Firebase, Hive, and runs the AutoVault app wrapped in a
/// ProviderScope for Riverpod state management.
///
/// Initialization flow:
/// 1. Ensure Flutter bindings are initialized
/// 2. Initialize Firebase with platform-specific configuration
/// 3. Initialize Hive for local data storage
/// 4. Open the authentication Hive box
/// 5. Launch the app with Riverpod's ProviderScope
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox(HiveBoxes.auth);

  runApp(
    const ProviderScope(
      child: AutoVault(),
    ),
  );
}
