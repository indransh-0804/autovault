/// Authentication state management using Riverpod and Firebase.
///
/// This file provides the complete authentication system for AutoVault, including:
/// - **Sign-in/Sign-up**: Email/password authentication via Firebase
/// - **State Management**: Riverpod-based auth state with local caching
/// - **Persistence**: Hive storage for offline access and fast app startup
/// - **Password Reset**: Email-based password recovery
/// - **User Refresh**: Sync user profile from Firestore
///
/// ## Architecture
///
/// The auth system follows a layered architecture:
/// ```
/// UI (Screens) → AuthNotifier (State) → Firebase Auth + Firestore → Hive Cache
/// ```
///
/// ## State Flow
///
/// 1. **App Startup**: AuthNotifier reads from Hive to restore previous session
/// 2. **Sign In**: Firebase Auth → Firestore (fetch profile) → Hive (cache) → Update state
/// 3. **Sign Up**: Firebase Auth → Firestore (create profile) → Hive (cache) → Update state
/// 4. **Sign Out**: Clear Firebase session → Clear Hive cache → Reset state
///
/// ## Storage
///
/// User data is stored in two places:
/// - **Firestore**: `users/{uid}` - Source of truth for user profiles
/// - **Hive**: `authBox.currentUser` - Local cache for offline access
///
/// ## Usage
///
/// ```dart
/// // In UI code
/// final authState = ref.watch(authNotifierProvider);
/// if (authState.isAuthenticated) {
///   // User is signed in
///   final user = authState.currentUser;
/// }
///
/// // Sign in
/// final user = await ref.read(authNotifierProvider.notifier).signIn(email, password);
///
/// // Sign out
/// await ref.read(authNotifierProvider.notifier).signOut();
/// ```
library;

import 'dart:convert';
import 'package:autovault/data/models/user_model.dart';
import 'package:autovault/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Convenience getter for the auth Hive box.
Box get _authBox => Hive.box(HiveBoxes.auth);

/// Convenience getter for Firebase Auth instance.
FirebaseAuth get _fbAuth => FirebaseAuth.instance;

/// Convenience getter for Firestore instance.
FirebaseFirestore get _db => FirebaseFirestore.instance;

/// Represents the current authentication state of the app.
///
/// Holds:
/// - Current user profile (null if not authenticated)
/// - Loading state for async operations
/// - Error messages from failed operations
///
/// This is an immutable value class with a `copyWith` method for updates.
class AuthState {
  /// The currently authenticated user, or null if not signed in.
  final UserModel? currentUser;

  /// Whether an async auth operation is in progress.
  ///
  /// Used to show loading indicators during sign-in, sign-up, etc.
  final bool isLoading;

  /// Error message from the last failed operation, or null if no error.
  final String? error;

  /// Creates an authentication state.
  const AuthState({
    this.currentUser,
    this.isLoading = false,
    this.error,
  });

  /// Returns true if a user is currently authenticated.
  ///
  /// Used by the router for navigation guards and by UI for conditional rendering.
  bool get isAuthenticated => currentUser != null;

  /// Creates a copy of this state with some fields replaced.
  ///
  /// Use [clearUser] to explicitly set currentUser to null.
  /// Use [clearError] to explicitly clear the error message.
  AuthState copyWith({
    UserModel? currentUser,
    bool clearUser = false,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      AuthState(
        currentUser: clearUser ? null : currentUser ?? this.currentUser,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : error ?? this.error,
      );
}

/// Authentication state notifier managing the entire auth lifecycle.
///
/// This Riverpod notifier:
/// - Initializes auth state from Hive on app startup
/// - Handles sign-in and sign-up flows
/// - Persists user data to Hive for offline access
/// - Syncs user profiles from Firestore
/// - Manages error states and loading indicators
///
/// All auth operations are async and update the state accordingly.
@riverpod
class AuthNotifier extends _$AuthNotifier {
  /// Initializes the auth state by loading cached user from Hive.
  ///
  /// Called automatically when the provider is first accessed.
  /// If a cached user exists and is valid, returns authenticated state.
  /// If no cache or invalid data, returns unauthenticated state.
  @override
  AuthState build() {
    final raw = _authBox.get(HiveKeys.currentUser);
    if (raw == null) return const AuthState();

    try {
      final user = UserModel.fromJson(
        Map<String, dynamic>.from(jsonDecode(raw as String) as Map),
      );
      return AuthState(currentUser: user);
    } catch (_) {
      // Corrupted cache - clear it and start fresh
      _authBox.deleteAll([
        HiveKeys.currentUser,
        HiveKeys.authToken,
        HiveKeys.userRole,
      ]);
      return const AuthState();
    }
  }

  // ── Sign In ────────────────────────────────────────────────────────────────
  //
  // Flow:
  //   1. Firebase Auth signInWithEmailAndPassword
  //   2. Fetch full UserModel from Firestore (cloud is source of truth)
  //   3. Persist fetched user + auth token to Hive
  //   4. Update state

  /// Signs in a user with email and password.
  ///
  /// ## Flow
  ///
  /// 1. Authenticate with Firebase Auth
  /// 2. Fetch user profile from Firestore `users/{uid}`
  /// 3. Cache user data in Hive for offline access
  /// 4. Update state with authenticated user
  ///
  /// ## Parameters
  ///
  /// - [email]: User's email address
  /// - [password]: User's password
  ///
  /// ## Returns
  ///
  /// - [UserModel] on success
  /// - `null` on failure (error message set in state)
  ///
  /// ## Errors
  ///
  /// Common error codes:
  /// - `user-not-found`: No account with this email
  /// - `wrong-password`: Incorrect password
  /// - `invalid-credential`: Email or password is invalid
  /// - `network-request-failed`: No internet connection
  ///
  /// ## Example
  ///
  /// ```dart
  /// final user = await ref.read(authNotifierProvider.notifier).signIn(
  ///   'user@example.com',
  ///   'password123',
  /// );
  /// if (user != null) {
  ///   // Sign-in successful
  /// } else {
  ///   // Check state.error for error message
  /// }
  /// ```
  Future<UserModel?> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // Step 1 — Firebase Auth
      final credential = await _fbAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final uid = credential.user!.uid;

      // Step 2 — Fetch user profile from Firestore
      final doc = await _db.collection('users').doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'User profile not found in database.',
        );
      }

      final user = UserModel.fromJson(
        Map<String, dynamic>.from(doc.data()!),
      );

      // Step 3 — Persist to Hive
      await _persistToHive(user, uid);

      // Step 4 — Update state
      state = state.copyWith(isLoading: false, currentUser: user);
      return user;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _friendlyError(e.code),
      );
      return null;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Please try again.',
      );
      return null;
    }
  }

  // ── Complete Sign Up ───────────────────────────────────────────────────────
  //
  // Flow:
  //   1. Firebase Auth createUserWithEmailAndPassword
  //   2. Assign the Firebase UID to the UserModel
  //   3. Write UserModel to Firestore
  //   4. Persist to Hive (use locally-entered data — no cloud fetch needed)
  //   5. Update state
  //

  /// Completes the sign-up process by creating a Firebase account.
  ///
  /// This is called at the end of the multi-step sign-up flow after
  /// email verification and profile information collection.
  ///
  /// ## Flow
  ///
  /// 1. Create Firebase Authentication account
  /// 2. Assign Firebase UID to user model
  /// 3. Save complete user profile to Firestore
  /// 4. Cache user data in Hive
  /// 5. Update state with authenticated user
  ///
  /// ## Parameters
  ///
  /// - [user]: Complete user model with profile information
  /// - [password]: User's chosen password
  ///
  /// ## Returns
  ///
  /// - [UserModel] with Firebase UID on success
  /// - `null` on failure (error message set in state)
  ///
  /// ## Example
  ///
  /// ```dart
  /// final newUser = UserModel(
  ///   id: '', // Will be replaced with Firebase UID
  ///   email: 'newuser@example.com',
  ///   firstName: 'John',
  ///   lastName: 'Doe',
  ///   role: UserRole.owner,
  ///   createdAt: DateTime.now(),
  /// );
  ///
  /// final user = await ref.read(authNotifierProvider.notifier).completeSignUp(
  ///   newUser,
  ///   'password123',
  /// );
  /// ```
  Future<UserModel?> completeSignUp(
    UserModel user,
    String password,
  ) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // Step 1 — Firebase Auth
      final credential = await _fbAuth.createUserWithEmailAndPassword(
        email: user.email.trim(),
        password: password,
      );

      final uid = credential.user!.uid;

      // Step 2 — Assign real Firebase UID
      final finalUser = user.copyWith(id: uid);

      // Step 3 — Write to Firestore
      await _db.collection('users').doc(uid).set(finalUser.toJson());

      // Step 4 — Persist to Hive (from local form data)
      await _persistToHive(finalUser, uid);

      // Step 5 — Update state
      state = state.copyWith(isLoading: false, currentUser: finalUser);
      return finalUser;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _friendlyError(e.code),
      );
      return null;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Sign up failed. Please try again.',
      );
      return null;
    }
  }

  // ── Forgot Password ────────────────────────────────────────────────────────

  /// Sends a password reset email to the user.
  ///
  /// Firebase Auth will send an email with a link to reset the password.
  /// The user must click the link to complete the password reset process.
  ///
  /// ## Parameters
  ///
  /// - [email]: Email address to send the reset link to
  ///
  /// ## Returns
  ///
  /// - `true` if email was sent successfully
  /// - `false` if there was an error (error message set in state)
  ///
  /// ## Example
  ///
  /// ```dart
  /// final success = await ref.read(authNotifierProvider.notifier)
  ///   .sendPasswordReset('user@example.com');
  /// if (success) {
  ///   // Show success message to user
  /// }
  /// ```
  Future<bool> sendPasswordReset(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _fbAuth.sendPasswordResetEmail(email: email.trim());
      state = state.copyWith(isLoading: false);
      return true;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _friendlyError(e.code),
      );
      return false;
    }
  }

  // ── Sign Out ───────────────────────────────────────────────────────────────

  /// Signs out the current user.
  ///
  /// Clears:
  /// - Firebase Auth session
  /// - Hive cached user data
  /// - In-memory auth state
  ///
  /// After sign-out, the router will automatically redirect to the sign-in screen.
  ///
  /// ## Example
  ///
  /// ```dart
  /// await ref.read(authNotifierProvider.notifier).signOut();
  /// ```
  Future<void> signOut() async {
    await _fbAuth.signOut();
    await _authBox.deleteAll([
      HiveKeys.currentUser,
      HiveKeys.authToken,
      HiveKeys.userRole,
    ]);
    state = const AuthState();
  }

  // ── Refresh from Firestore ─────────────────────────────────────────────────
  // Call this if you need to sync latest profile changes from the cloud.

  /// Refreshes the user profile from Firestore.
  ///
  /// Fetches the latest user data from Firestore and updates both
  /// the Hive cache and the in-memory state. Use this after profile
  /// updates to ensure the UI reflects the latest data.
  ///
  /// This is a non-fatal operation - if it fails, the existing
  /// state is preserved.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // After updating user profile in Firestore
  /// await ref.read(authNotifierProvider.notifier).refreshUser();
  /// ```
  Future<void> refreshUser() async {
    final uid = _fbAuth.currentUser?.uid;
    if (uid == null) return;

    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (!doc.exists) return;

      final user = UserModel.fromJson(
        Map<String, dynamic>.from(doc.data()!),
      );
      await _persistToHive(user, uid);
      state = state.copyWith(currentUser: user);
    } catch (_) {
      // Non-fatal — keep existing state
    }
  }

  // ── Hive persistence helper ────────────────────────────────────────────────

  /// Persists user data to Hive for offline access.
  ///
  /// Stores:
  /// - Complete user profile (JSON-serialized)
  /// - Auth token (Firebase UID)
  /// - User role (for quick access)
  ///
  /// This enables:
  /// - Fast app startup (no network call needed)
  /// - Offline authentication state
  /// - Role-based routing on app restart
  Future<void> _persistToHive(UserModel user, String uid) async {
    await Future.wait([
      _authBox.put(HiveKeys.currentUser, jsonEncode(user.toJson())),
      _authBox.put(HiveKeys.authToken, uid),
      _authBox.put(HiveKeys.userRole, user.role.name),
    ]);
  }

  // ── Error messages ─────────────────────────────────────────────────────────

  /// Converts Firebase error codes to user-friendly messages.
  ///
  /// Takes Firebase's technical error codes and returns messages
  /// that are appropriate to show to end users.
  String _friendlyError(String code) => switch (code) {
        'user-not-found' => 'No account found with this email.',
        'wrong-password' => 'Incorrect password. Please try again.',
        'invalid-credential' => 'Invalid email or password.',
        'invalid-email' => 'Please enter a valid email address.',
        'email-already-in-use' => 'An account with this email already exists.',
        'weak-password' => 'Password is too weak. Use at least 6 characters.',
        'too-many-requests' => 'Too many attempts. Please try again later.',
        'network-request-failed' => 'No internet connection.',
        _ => 'Something went wrong. Please try again.',
      };

  /// Clears the current error message from the state.
  ///
  /// Use this to dismiss error messages after the user has seen them.
  void clearError() => state = state.copyWith(clearError: true);
}

// ─── Convenience providers ─────────────────────────────────────────────────────

/// Provider that returns true if a user is authenticated.
///
/// Convenience provider for checking auth status in UI code.
///
/// Example:
/// ```dart
/// final isAuth = ref.watch(isAuthenticatedProvider);
/// if (isAuth) {
///   // Show authenticated content
/// }
/// ```
@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) =>
    ref.watch(authNotifierProvider).isAuthenticated;

/// Provider that returns the current user, or null if not authenticated.
///
/// Convenience provider for accessing user data in UI code.
///
/// Example:
/// ```dart
/// final user = ref.watch(currentUserProvider);
/// if (user != null) {
///   Text('Welcome, ${user.fullName}');
/// }
/// ```
@riverpod
UserModel? currentUser(CurrentUserRef ref) =>
    ref.watch(authNotifierProvider).currentUser;

/// Provider that returns the current user's role.
///
/// Defaults to employee if no user is authenticated.
///
/// Example:
/// ```dart
/// final role = ref.watch(currentUserRoleProvider);
/// if (role == UserRole.owner) {
///   // Show owner-only features
/// }
/// ```
@riverpod
UserRole currentUserRole(CurrentUserRoleRef ref) =>
    ref.watch(authNotifierProvider).currentUser?.role ?? UserRole.employee;

/// Provider that returns true if the current user is an owner.
///
/// Convenience provider for role-based UI rendering.
///
/// Example:
/// ```dart
/// final isOwner = ref.watch(isOwnerProvider);
/// if (isOwner) {
///   // Show owner-only controls
/// }
/// ```
@riverpod
bool isOwner(IsOwnerRef ref) =>
    ref.watch(currentUserRoleProvider) == UserRole.owner;
