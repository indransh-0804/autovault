// data/models/test_drive_model.dart
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'test_drive_activity_model.dart';

part 'test_drive_model.freezed.dart';
part 'test_drive_model.g.dart';

// ─── Status enum ──────────────────────────────────────────────────────────────

enum TestDriveStatus {
  @JsonValue('pending')    pending,
  @JsonValue('confirmed')  confirmed,
  @JsonValue('in_progress') inProgress,
  @JsonValue('completed')  completed,
  @JsonValue('cancelled')  cancelled,
}

extension TestDriveStatusX on TestDriveStatus {
  String get label => switch (this) {
        TestDriveStatus.pending    => 'Pending',
        TestDriveStatus.confirmed  => 'Confirmed',
        TestDriveStatus.inProgress => 'In Progress',
        TestDriveStatus.completed  => 'Completed',
        TestDriveStatus.cancelled  => 'Cancelled',
      };

  bool get isActive =>
      this == TestDriveStatus.pending ||
      this == TestDriveStatus.confirmed ||
      this == TestDriveStatus.inProgress;

  bool get isClosed =>
      this == TestDriveStatus.completed ||
      this == TestDriveStatus.cancelled;
}

// ─── Model ────────────────────────────────────────────────────────────────────

@freezed
class TestDriveModel with _$TestDriveModel {
  const TestDriveModel._();

  const factory TestDriveModel({
    required String id,
    // Customer snapshot
    required String customerId,
    required String customerName,
    required String customerPhone,
    // Car snapshot
    required String carId,
    required String carMake,
    required String carModel,
    required int carYear,
    // Assignment
    required String assignedEmployeeId,
    required String assignedEmployeeName,
    // Schedule
    required DateTime scheduledAt,
    @Default(30) int durationMinutes,
    @Default(TestDriveStatus.pending) TestDriveStatus status,
    // Details
    @Default('') String location,
    @Default('') String notes,
    @Default([]) List<TestDriveActivityModel> activityLog,
    required DateTime createdAt,
    String? convertedToPurchaseId,
  }) = _TestDriveModel;

  // Computed
  DateTime get scheduledEnd =>
      scheduledAt.add(Duration(minutes: durationMinutes));

  String get carDisplayName => '$carMake $carModel ($carYear)';

  bool get isPast => scheduledAt.isBefore(DateTime.now());

  factory TestDriveModel.fromJson(Map<String, dynamic> json) =>
      _$TestDriveModelFromJson(json);
}
