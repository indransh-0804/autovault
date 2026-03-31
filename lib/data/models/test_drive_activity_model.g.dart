// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_drive_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestDriveActivityModelImpl _$$TestDriveActivityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TestDriveActivityModelImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      description: json['description'] as String,
      type: $enumDecode(_$TestDriveActivityTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$TestDriveActivityModelImplToJson(
        _$TestDriveActivityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'description': instance.description,
      'type': _$TestDriveActivityTypeEnumMap[instance.type]!,
    };

const _$TestDriveActivityTypeEnumMap = {
  TestDriveActivityType.booked: 'booked',
  TestDriveActivityType.confirmed: 'confirmed',
  TestDriveActivityType.statusChanged: 'status_changed',
  TestDriveActivityType.rescheduled: 'rescheduled',
  TestDriveActivityType.noted: 'noted',
  TestDriveActivityType.cancelled: 'cancelled',
  TestDriveActivityType.converted: 'converted',
};
