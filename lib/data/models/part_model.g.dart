// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartModelImpl _$$PartModelImplFromJson(Map<String, dynamic> json) =>
    _$PartModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      partNumber: json['partNumber'] as String,
      category: $enumDecode(_$PartCategoryEnumMap, json['category']),
      supplierId: json['supplierId'] as String,
      supplierName: json['supplierName'] as String,
      quantity: (json['quantity'] as num).toInt(),
      reorderLevel: (json['reorderLevel'] as num).toInt(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PartModelImplToJson(_$PartModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'partNumber': instance.partNumber,
      'category': _$PartCategoryEnumMap[instance.category]!,
      'supplierId': instance.supplierId,
      'supplierName': instance.supplierName,
      'quantity': instance.quantity,
      'reorderLevel': instance.reorderLevel,
      'unitPrice': instance.unitPrice,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$PartCategoryEnumMap = {
  PartCategory.engine: 'engine',
  PartCategory.brakes: 'brakes',
  PartCategory.electrical: 'electrical',
  PartCategory.body: 'body',
  PartCategory.tyres: 'tyres',
  PartCategory.interior: 'interior',
  PartCategory.other: 'other',
};
