// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InteractionModelImpl _$$InteractionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InteractionModelImpl(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      type: $enumDecode(_$InteractionTypeEnumMap, json['type']),
      note: json['note'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$InteractionModelImplToJson(
        _$InteractionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'type': _$InteractionTypeEnumMap[instance.type]!,
      'note': instance.note,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$InteractionTypeEnumMap = {
  InteractionType.call: 'call',
  InteractionType.visit: 'visit',
  InteractionType.testDrive: 'test_drive',
  InteractionType.purchase: 'purchase',
};
