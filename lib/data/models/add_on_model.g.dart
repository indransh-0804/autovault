// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_on_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddOnModelImpl _$$AddOnModelImplFromJson(Map<String, dynamic> json) =>
    _$AddOnModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      isCustom: json['isCustom'] as bool? ?? false,
    );

Map<String, dynamic> _$$AddOnModelImplToJson(_$AddOnModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'isCustom': instance.isCustom,
    };
