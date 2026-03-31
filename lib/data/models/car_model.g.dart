// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CarModelImpl _$$CarModelImplFromJson(Map<String, dynamic> json) =>
    _$CarModelImpl(
      id: json['id'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      vin: json['vin'] as String,
      color: json['color'] as String,
      condition: $enumDecode(_$CarConditionEnumMap, json['condition']),
      fuelType: $enumDecode(_$FuelTypeEnumMap, json['fuelType']),
      transmission: $enumDecode(_$TransmissionEnumMap, json['transmission']),
      mileage: (json['mileage'] as num?)?.toInt() ?? 0,
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      status: $enumDecodeNullable(_$CarStatusEnumMap, json['status']) ??
          CarStatus.available,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      description: json['description'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CarModelImplToJson(_$CarModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'vin': instance.vin,
      'color': instance.color,
      'condition': _$CarConditionEnumMap[instance.condition]!,
      'fuelType': _$FuelTypeEnumMap[instance.fuelType]!,
      'transmission': _$TransmissionEnumMap[instance.transmission]!,
      'mileage': instance.mileage,
      'purchasePrice': instance.purchasePrice,
      'sellingPrice': instance.sellingPrice,
      'status': _$CarStatusEnumMap[instance.status]!,
      'imageUrls': instance.imageUrls,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$CarConditionEnumMap = {
  CarCondition.newCar: 'new',
  CarCondition.used: 'used',
};

const _$FuelTypeEnumMap = {
  FuelType.petrol: 'petrol',
  FuelType.diesel: 'diesel',
  FuelType.electric: 'electric',
  FuelType.hybrid: 'hybrid',
};

const _$TransmissionEnumMap = {
  Transmission.automatic: 'automatic',
  Transmission.manual: 'manual',
};

const _$CarStatusEnumMap = {
  CarStatus.available: 'available',
  CarStatus.reserved: 'reserved',
  CarStatus.sold: 'sold',
};
