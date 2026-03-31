// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerModelImpl _$$CustomerModelImplFromJson(Map<String, dynamic> json) =>
    _$CustomerModelImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      address: json['address'] as String? ?? '',
      assignedEmployeeId: json['assignedEmployeeId'] as String? ?? '',
      assignedEmployeeName: json['assignedEmployeeName'] as String? ?? '',
      leadStatus:
          $enumDecodeNullable(_$LeadStatusEnumMap, json['leadStatus']) ??
              LeadStatus.hotLead,
      notes: json['notes'] as String? ?? '',
      purchaseIds: (json['purchaseIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      loanIds: (json['loanIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      testDriveIds: (json['testDriveIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastInteractionAt: DateTime.parse(json['lastInteractionAt'] as String),
    );

Map<String, dynamic> _$$CustomerModelImplToJson(_$CustomerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'address': instance.address,
      'assignedEmployeeId': instance.assignedEmployeeId,
      'assignedEmployeeName': instance.assignedEmployeeName,
      'leadStatus': _$LeadStatusEnumMap[instance.leadStatus]!,
      'notes': instance.notes,
      'purchaseIds': instance.purchaseIds,
      'loanIds': instance.loanIds,
      'testDriveIds': instance.testDriveIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastInteractionAt': instance.lastInteractionAt.toIso8601String(),
    };

const _$LeadStatusEnumMap = {
  LeadStatus.hotLead: 'hot_lead',
  LeadStatus.followUp: 'follow_up',
  LeadStatus.converted: 'converted',
  LeadStatus.inactive: 'inactive',
};
