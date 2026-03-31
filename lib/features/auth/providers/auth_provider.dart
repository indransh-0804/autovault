import 'dart:convert';
import 'package:autovault/data/models/user_model.dart';
import 'package:autovault/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

Box get _authBox => Hive.box(HiveBoxes.auth);

FirebaseAuth get _fbAuth => FirebaseAuth.instance;

FirebaseFirestore get _db => FirebaseFirestore.instance;

class AuthState {
  final UserModel? currentUser;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.currentUser,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => currentUser != null;

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

@riverpod
class AuthNotifier extends _$AuthNotifier {
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

  Future<void> _persistToHive(UserModel user, String uid) async {
    await Future.wait([
      _authBox.put(HiveKeys.currentUser, jsonEncode(user.toJson())),
      _authBox.put(HiveKeys.authToken, uid),
      _authBox.put(HiveKeys.userRole, user.role.name),
    ]);
  }

  // ── Error messages ─────────────────────────────────────────────────────────

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

  void clearError() => state = state.copyWith(clearError: true);
}

// ─── Convenience providers ─────────────────────────────────────────────────────

@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) =>
    ref.watch(authNotifierProvider).isAuthenticated;

@riverpod
UserModel? currentUser(CurrentUserRef ref) =>
    ref.watch(authNotifierProvider).currentUser;

@riverpod
UserRole currentUserRole(CurrentUserRoleRef ref) =>
    ref.watch(authNotifierProvider).currentUser?.role ?? UserRole.employee;

@riverpod
bool isOwner(IsOwnerRef ref) =>
    ref.watch(currentUserRoleProvider) == UserRole.owner;
