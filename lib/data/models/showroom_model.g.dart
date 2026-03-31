// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showroom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShowroomModelImpl _$$ShowroomModelImplFromJson(Map<String, dynamic> json) =>
    _$ShowroomModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      gstNumber: json['gstNumber'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      pinCode: json['pinCode'] as String? ?? '',
      logoUrl: json['logoUrl'] as String? ?? '',
      ownerId: json['ownerId'] as String,
      showroomCode: json['showroomCode'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ShowroomModelImplToJson(_$ShowroomModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gstNumber': instance.gstNumber,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'pinCode': instance.pinCode,
      'logoUrl': instance.logoUrl,
      'ownerId': instance.ownerId,
      'showroomCode': instance.showroomCode,
      'createdAt': instance.createdAt.toIso8601String(),
    };
