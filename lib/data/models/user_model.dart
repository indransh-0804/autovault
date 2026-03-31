// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum UserRole {
  @JsonValue('owner')
  owner,
  @JsonValue('employee')
  employee,
}

extension UserRoleX on UserRole {
  String get label => switch (this) {
        UserRole.owner => 'Owner / Manager',
        UserRole.employee => 'Employee',
      };

  String get dashboardRoute => switch (this) {
        UserRole.owner => '/owner_dashboard',
        UserRole.employee => '/employee_dashboard',
      };
}

enum Gender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
  @JsonValue('prefer_not_to_say')
  preferNotToSay,
}

extension GenderX on Gender {
  String get label => switch (this) {
        Gender.male => 'Male',
        Gender.female => 'Female',
        Gender.preferNotToSay => 'Prefer not to say',
      };
}

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    @Default('') String phone,
    DateTime? dateOfBirth,
    Gender? gender,
    @Default(UserRole.employee) UserRole role,
    @Default('') String showroomId,
    @Default('') String profilePhotoUrl,
    @Default('') String employeeId,
    required DateTime createdAt,
  }) = _UserModel;

  String get fullName => '$firstName $lastName'.trim();

  bool get isOwner => role == UserRole.owner;
  bool get isEmployee => role == UserRole.employee;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
