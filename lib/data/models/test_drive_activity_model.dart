// data/models/test_drive_activity_model.dart
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_drive_activity_model.freezed.dart';
part 'test_drive_activity_model.g.dart';

enum TestDriveActivityType {
  @JsonValue('booked')        booked,
  @JsonValue('confirmed')     confirmed,
  @JsonValue('status_changed') statusChanged,
  @JsonValue('rescheduled')   rescheduled,
  @JsonValue('noted')         noted,
  @JsonValue('cancelled')     cancelled,
  @JsonValue('converted')     converted,
}

extension TestDriveActivityTypeX on TestDriveActivityType {
  String get label => switch (this) {
        TestDriveActivityType.booked        => 'Booked',
        TestDriveActivityType.confirmed     => 'Confirmed',
        TestDriveActivityType.statusChanged => 'Status Changed',
        TestDriveActivityType.rescheduled   => 'Rescheduled',
        TestDriveActivityType.noted         => 'Note Added',
        TestDriveActivityType.cancelled     => 'Cancelled',
        TestDriveActivityType.converted     => 'Converted to Sale',
      };

  String get emoji => switch (this) {
        TestDriveActivityType.booked        => '📅',
        TestDriveActivityType.confirmed     => '✅',
        TestDriveActivityType.statusChanged => '🔄',
        TestDriveActivityType.rescheduled   => '🕐',
        TestDriveActivityType.noted         => '📝',
        TestDriveActivityType.cancelled     => '❌',
        TestDriveActivityType.converted     => '🤝',
      };
}

@freezed
class TestDriveActivityModel with _$TestDriveActivityModel {
  const factory TestDriveActivityModel({
    required String id,
    required DateTime timestamp,
    required String description,
    required TestDriveActivityType type,
  }) = _TestDriveActivityModel;

  factory TestDriveActivityModel.fromJson(Map<String, dynamic> json) =>
      _$TestDriveActivityModelFromJson(json);
}
