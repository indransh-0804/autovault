// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_drive_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestDriveModelImpl _$$TestDriveModelImplFromJson(Map<String, dynamic> json) =>
    _$TestDriveModelImpl(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      customerPhone: json['customerPhone'] as String,
      carId: json['carId'] as String,
      carMake: json['carMake'] as String,
      carModel: json['carModel'] as String,
      carYear: (json['carYear'] as num).toInt(),
      assignedEmployeeId: json['assignedEmployeeId'] as String,
      assignedEmployeeName: json['assignedEmployeeName'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 30,
      status: $enumDecodeNullable(_$TestDriveStatusEnumMap, json['status']) ??
          TestDriveStatus.pending,
      location: json['location'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      activityLog: (json['activityLog'] as List<dynamic>?)
              ?.map((e) =>
                  TestDriveActivityModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      convertedToPurchaseId: json['convertedToPurchaseId'] as String?,
    );

Map<String, dynamic> _$$TestDriveModelImplToJson(
        _$TestDriveModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'carId': instance.carId,
      'carMake': instance.carMake,
      'carModel': instance.carModel,
      'carYear': instance.carYear,
      'assignedEmployeeId': instance.assignedEmployeeId,
      'assignedEmployeeName': instance.assignedEmployeeName,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'durationMinutes': instance.durationMinutes,
      'status': _$TestDriveStatusEnumMap[instance.status]!,
      'location': instance.location,
      'notes': instance.notes,
      'activityLog': instance.activityLog,
      'createdAt': instance.createdAt.toIso8601String(),
      'convertedToPurchaseId': instance.convertedToPurchaseId,
    };

const _$TestDriveStatusEnumMap = {
  TestDriveStatus.pending: 'pending',
  TestDriveStatus.confirmed: 'confirmed',
  TestDriveStatus.inProgress: 'in_progress',
  TestDriveStatus.completed: 'completed',
  TestDriveStatus.cancelled: 'cancelled',
};
