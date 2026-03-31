import 'package:autovault/data/models/showroom_model.dart';
import 'package:autovault/data/models/user_model.dart';
import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_provider.g.dart';

class SignUpCredentials {
  final String email;
  final String password;
  const SignUpCredentials({required this.email, required this.password});
}

class UserProfileData {
  final String firstName;
  final String lastName;
  final String phone;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final String profilePhotoPath;
  final String showroomCode;
  final String employeeId;

  const UserProfileData({
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.dateOfBirth,
    this.gender,
    this.profilePhotoPath = '',
    this.showroomCode = '',
    this.employeeId = '',
  });
}

class ShowroomFormData {
  final String name;
  final String gstNumber;
  final String phone;
  final String email;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String logoPath;

  const ShowroomFormData({
    required this.name,
    this.gstNumber = '',
    this.phone = '',
    this.email = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.pinCode = '',
    this.logoPath = '',
  });
}

enum SignUpStep {
  credentials,
  role,
  ownerShowroom,
  ownerPersonal,
  employeePersonal,
}

extension SignUpStepX on SignUpStep {
  int get progressNumerator => switch (this) {
        SignUpStep.credentials => 1,
        SignUpStep.role => 3,
        SignUpStep.ownerShowroom => 4,
        SignUpStep.ownerPersonal => 5,
        SignUpStep.employeePersonal => 4,
      };

  int get progressDenominator => switch (this) {
        SignUpStep.ownerShowroom => 5,
        SignUpStep.ownerPersonal => 5,
        SignUpStep.employeePersonal => 4,
        _ => 5,
      };

  double get progress => progressNumerator / progressDenominator;
}

class SignUpState {
  final SignUpStep currentStep;
  final SignUpCredentials? credentials;
  final bool emailVerified;
  final UserRole? selectedRole;
  final ShowroomFormData? showroomData;
  final UserProfileData? personalData;
  final bool isLoading;
  final String? error;

  const SignUpState({
    this.currentStep = SignUpStep.credentials,
    this.credentials,
    this.emailVerified = false,
    this.selectedRole,
    this.showroomData,
    this.personalData,
    this.isLoading = false,
    this.error,
  });

  SignUpState copyWith({
    SignUpStep? currentStep,
    SignUpCredentials? credentials,
    bool? emailVerified,
    UserRole? selectedRole,
    ShowroomFormData? showroomData,
    UserProfileData? personalData,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      SignUpState(
        currentStep: currentStep ?? this.currentStep,
        credentials: credentials ?? this.credentials,
        emailVerified: emailVerified ?? this.emailVerified,
        selectedRole: selectedRole ?? this.selectedRole,
        showroomData: showroomData ?? this.showroomData,
        personalData: personalData ?? this.personalData,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : error ?? this.error,
      );
}

@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  @override
  SignUpState build() => const SignUpState();

  void reset() => state = const SignUpState();

  // Step 1
  void setCredentials(String email, String password) => state = state.copyWith(
        credentials: SignUpCredentials(email: email, password: password),
      );

  // Step 2
  void verifyOtp() {
    state = state.copyWith(emailVerified: true, currentStep: SignUpStep.role);
  }

  void backToCredentials() =>
      state = state.copyWith(currentStep: SignUpStep.credentials);

  // Step 3
  void setRole(UserRole role) => state = state.copyWith(selectedRole: role);

  void goToNextAfterRole() {
    final step = state.selectedRole == UserRole.owner
        ? SignUpStep.ownerShowroom
        : SignUpStep.employeePersonal;
    state = state.copyWith(currentStep: step);
  }

  void backToRole() => state = state.copyWith(currentStep: SignUpStep.role);

  // Step 4 Owner
  void setShowroomData(ShowroomFormData? data) => state = state.copyWith(
        showroomData: data,
        currentStep: SignUpStep.ownerPersonal,
      );

  void backToOwnerShowroom() =>
      state = state.copyWith(currentStep: SignUpStep.ownerShowroom);

  // Step 5 Owner / Step 4 Employee
  void setPersonalData(UserProfileData data) =>
      state = state.copyWith(personalData: data);

  UserModel buildUserModel() {
    final personal = state.personalData!;
    return UserModel(
      id: 'pending', // replaced by Firebase UID in auth_provider
      email: state.credentials!.email.trim(),
      firstName: personal.firstName,
      lastName: personal.lastName,
      phone: personal.phone,
      dateOfBirth: personal.dateOfBirth,
      gender: personal.gender,
      role: state.selectedRole ?? UserRole.employee,
      showroomId: '',
      profilePhotoUrl: '',
      employeeId: personal.employeeId,
      createdAt: DateTime.now(),
    );
  }

  ShowroomModel? buildShowroomModel(String ownerId) {
    final d = state.showroomData;
    if (d == null) return null;
    return ShowroomModel(
      id: 'pending',
      name: d.name,
      gstNumber: d.gstNumber,
      phone: d.phone,
      email: d.email,
      address: d.address,
      city: d.city,
      state: d.state,
      pinCode: d.pinCode,
      ownerId: ownerId,
      showroomCode: _generateCode(),
      createdAt: DateTime.now(),
    );
  }

  // ── Complete signup — called from the final personal step screens ──────────
  //
  // This is the single method the UI calls. It:
  //   1. Saves personalData to state
  //   2. Builds the UserModel
  //   3. Calls authNotifier.completeSignUp(user, password) which handles
  //      Firebase + Hive persistence
  //   4. Navigates on success

  Future<void> completeSignUp(
    UserProfileData personalData,
    WidgetRef ref,
    BuildContext context,
  ) async {
    setPersonalData(personalData);

    final user = buildUserModel();
    final password = state.credentials!.password;
    final role = state.selectedRole ?? UserRole.employee;

    final result = await ref
        .read(authNotifierProvider.notifier)
        .completeSignUp(user, password);

    if (!context.mounted) return;

    if (result != null) {
      reset(); // clear signup form state
      context.go(role.dashboardRoute);
    }
  }

  String _generateCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    return List.generate(6, (i) {
      final seed = DateTime.now().microsecondsSinceEpoch + i * 37;
      return chars[seed % chars.length];
    }).join();
  }
}

@riverpod
SignUpStep currentSignUpStep(CurrentSignUpStepRef ref) =>
    ref.watch(signUpNotifierProvider).currentStep;

@riverpod
double signUpProgress(SignUpProgressRef ref) =>
    ref.watch(signUpNotifierProvider).currentStep.progress;

// ─── HOW TO CALL completeSignUp FROM THE STEP SCREENS ────────────────────────
//
// Replace the existing _completeSetup() body in both:
//   signup_step5_owner_personal.dart
//   signup_step4_employee_personal.dart
//
// With this single call (everything else — loading overlay, error SnackBar —
// stays the same, just driven by authNotifierProvider.isLoading / .error):
//
//   Future<void> _completeSetup() async {
//     if (!_formKey.currentState!.validate()) return;
//     FocusScope.of(context).unfocus();
//
//     final personal = UserProfileData(
//       firstName: _firstCtr.text.trim(),
//       lastName:  _lastCtr.text.trim(),
//       phone:     '+91${_phoneCtr.text.trim()}',
//       dateOfBirth: _dob,
//       gender:    _gender,
//       // employee only:
//       showroomCode: _codeCtr.text.trim().toUpperCase(),
//       employeeId:   _empIdCtr.text.trim(),
//     );
//
//     await ref
//         .read(signUpNotifierProvider.notifier)
//         .completeSignUp(personal, ref, context);
//
//     // Show error from auth provider if it failed
//     final error = ref.read(authNotifierProvider).error;
//     if (error != null && mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(error)),
//       );
//       ref.read(authNotifierProvider.notifier).clearError();
//     }
//   }
//
// Also update the loading state check:
//   final isLoading = ref.watch(authNotifierProvider).isLoading;
//
// So the loading overlay is driven by authNotifierProvider, not local state.
