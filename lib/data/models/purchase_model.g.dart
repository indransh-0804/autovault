// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CarSnapshotImpl _$$CarSnapshotImplFromJson(Map<String, dynamic> json) =>
    _$CarSnapshotImpl(
      carId: json['carId'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      vin: json['vin'] as String,
      color: json['color'] as String,
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$CarSnapshotImplToJson(_$CarSnapshotImpl instance) =>
    <String, dynamic>{
      'carId': instance.carId,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'vin': instance.vin,
      'color': instance.color,
      'sellingPrice': instance.sellingPrice,
    };

_$PurchaseModelImpl _$$PurchaseModelImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseModelImpl(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      carDetails:
          CarSnapshot.fromJson(json['carDetails'] as Map<String, dynamic>),
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      addOns: (json['addOns'] as List<dynamic>?)
              ?.map((e) => AddOnModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      discountType:
          $enumDecodeNullable(_$DiscountTypeEnumMap, json['discountType']) ??
              DiscountType.flat,
      discountValue: (json['discountValue'] as num?)?.toDouble() ?? 0,
      subtotal: (json['subtotal'] as num).toDouble(),
      gstAmount: (json['gstAmount'] as num).toDouble(),
      gstRate: (json['gstRate'] as num?)?.toDouble() ?? 0.28,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['paymentMethod']) ??
              PaymentMethod.fullPayment,
      downPayment: (json['downPayment'] as num?)?.toDouble() ?? 0,
      loanId: json['loanId'] as String?,
      status: $enumDecodeNullable(_$PurchaseStatusEnumMap, json['status']) ??
          PurchaseStatus.completed,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PurchaseModelImplToJson(_$PurchaseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'carDetails': instance.carDetails,
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'addOns': instance.addOns,
      'discountType': _$DiscountTypeEnumMap[instance.discountType]!,
      'discountValue': instance.discountValue,
      'subtotal': instance.subtotal,
      'gstAmount': instance.gstAmount,
      'gstRate': instance.gstRate,
      'totalAmount': instance.totalAmount,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'downPayment': instance.downPayment,
      'loanId': instance.loanId,
      'status': _$PurchaseStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$DiscountTypeEnumMap = {
  DiscountType.flat: 'flat',
  DiscountType.percentage: 'percentage',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.fullPayment: 'full_payment',
  PaymentMethod.loan: 'loan',
  PaymentMethod.partPayment: 'part_payment',
};

const _$PurchaseStatusEnumMap = {
  PurchaseStatus.completed: 'completed',
  PurchaseStatus.voided: 'voided',
};
