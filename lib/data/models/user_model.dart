/// User data model and authentication role definitions.
///
/// This file defines the core user model used throughout AutoVault for:
/// - Authentication and authorization
/// - Role-based access control (Owner vs Employee)
/// - User profile management
/// - Showroom association
///
/// The user model uses Freezed for immutability and JSON serialization support.
library;

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User role enumeration for role-based access control.
///
/// Defines two distinct user types with different capabilities:
/// - **Owner**: Full access to all features, analytics, and settings
/// - **Employee**: Limited access to assigned customers and personal tasks
///
/// The role determines:
/// - Which dashboard is displayed after login
/// - Which features are accessible in the navigation
/// - What data the user can view/modify
enum UserRole {
  /// Owner/Manager role with full system access.
  ///
  /// Capabilities:
  /// - View all customers, sales, and analytics
  /// - Manage employees and showroom settings
  /// - Approve loans and configure pricing
  /// - Access financial reports and KPIs
  @JsonValue('owner')
  owner,

  /// Employee/Salesperson role with scoped access.
  ///
  /// Capabilities:
  /// - View and manage assigned customers only
  /// - Create purchases and generate receipts
  /// - Schedule and track test drives
  /// - Track personal shift attendance and performance
  @JsonValue('employee')
  employee,
}

/// Extension methods for [UserRole] to provide human-readable labels and routes.
extension UserRoleX on UserRole {
  /// Returns the user-friendly display label for the role.
  ///
  /// Used in:
  /// - Role selection during sign-up
  /// - Profile display
  /// - User management screens
  String get label => switch (this) {
        UserRole.owner => 'Owner / Manager',
        UserRole.employee => 'Employee',
      };

  /// Returns the dashboard route path for the role.
  ///
  /// Used by the router's redirect logic to send authenticated users
  /// to their role-appropriate dashboard after login.
  ///
  /// Routes:
  /// - Owner → `/owner_dashboard`
  /// - Employee → `/employee_dashboard`
  String get dashboardRoute => switch (this) {
        UserRole.owner => '/owner_dashboard',
        UserRole.employee => '/employee_dashboard',
      };
}

/// Gender enumeration for user profiles.
///
/// Includes a privacy-conscious option to not disclose gender.
enum Gender {
  /// Male gender.
  @JsonValue('male')
  male,

  /// Female gender.
  @JsonValue('female')
  female,

  /// User prefers not to specify gender.
  @JsonValue('prefer_not_to_say')
  preferNotToSay,
}

/// Extension methods for [Gender] to provide display labels.
extension GenderX on Gender {
  /// Returns the user-friendly display label for the gender.
  String get label => switch (this) {
        Gender.male => 'Male',
        Gender.female => 'Female',
        Gender.preferNotToSay => 'Prefer not to say',
      };
}

/// User profile model representing an authenticated user in the system.
///
/// This model stores complete user information including:
/// - Basic identification (name, email, phone)
/// - Personal details (date of birth, gender)
/// - Role and permissions (owner or employee)
/// - Showroom association
/// - Profile photo URL
///
/// The model is immutable (Freezed) and provides:
/// - Automatic `copyWith` for updates
/// - JSON serialization for Firestore and Hive storage
/// - Equality comparison
/// - Computed properties for common operations
///
/// ## Storage
///
/// User data is stored in two places:
/// 1. **Firestore**: `users/{userId}` - Source of truth
/// 2. **Hive**: `authBox.currentUser` - Local cache for offline access
///
/// ## Lifecycle
///
/// - **Created**: During sign-up after email verification
/// - **Updated**: Through profile editing screens
/// - **Deleted**: (Not implemented - users are deactivated in production)
///
/// ## Usage Example
///
/// ```dart
/// final user = UserModel(
///   id: 'firebase-uid',
///   email: 'john@example.com',
///   firstName: 'John',
///   lastName: 'Doe',
///   phone: '+919876543210',
///   role: UserRole.owner,
///   showroomId: 'showroom123',
///   createdAt: DateTime.now(),
/// );
///
/// // Access computed properties
/// print(user.fullName); // "John Doe"
/// print(user.isOwner); // true
/// ```
@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    /// Unique identifier (Firebase UID).
    ///
    /// This ID is assigned by Firebase Authentication during sign-up
    /// and is used as the document ID in Firestore's `users` collection.
    required String id,

    /// User's email address (used for authentication).
    ///
    /// Must be unique across the system and is verified during sign-up.
    required String email,

    /// User's first name.
    required String firstName,

    /// User's last name.
    required String lastName,

    /// User's phone number with country code (e.g., +919876543210).
    ///
    /// Used for:
    /// - Contact information display
    /// - SMS notifications (future feature)
    /// - WhatsApp integration (future feature)
    @Default('') String phone,

    /// User's date of birth (optional).
    ///
    /// Used for age calculation in profile displays and analytics.
    DateTime? dateOfBirth,

    /// User's gender (optional).
    Gender? gender,

    /// User's role determining access level and permissions.
    ///
    /// Defaults to employee if not specified during sign-up.
    @Default(UserRole.employee) UserRole role,

    /// ID of the showroom this user belongs to.
    ///
    /// - **Owners**: This is the showroom they created during sign-up
    /// - **Employees**: This is the showroom they joined using a showroom code
    ///
    /// All users must be associated with exactly one showroom.
    @Default('') String showroomId,

    /// URL to the user's profile photo in Firebase Storage.
    ///
    /// Empty string if no photo has been uploaded.
    @Default('') String profilePhotoUrl,

    /// Employee ID number for employees (owner-assigned).
    ///
    /// Used for internal identification and payroll systems.
    /// Empty for owner accounts.
    @Default('') String employeeId,

    /// Timestamp when the user account was created.
    required DateTime createdAt,
  }) = _UserModel;

  /// Returns the user's full name (first + last name).
  ///
  /// Used throughout the UI for display purposes:
  /// - App bar greeting: "Welcome, John Doe"
  /// - Customer assignment: "Assigned to: John Doe"
  /// - Activity logs: "Purchase created by John Doe"
  String get fullName => '$firstName $lastName'.trim();

  /// Returns true if the user is an owner.
  ///
  /// Convenience getter for role checks in UI and business logic.
  bool get isOwner => role == UserRole.owner;

  /// Returns true if the user is an employee.
  ///
  /// Convenience getter for role checks in UI and business logic.
  bool get isEmployee => role == UserRole.employee;

  /// Creates a [UserModel] from a JSON map.
  ///
  /// Used for:
  /// - Deserializing from Firestore documents
  /// - Deserializing from Hive storage
  /// - API response parsing (future feature)
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
