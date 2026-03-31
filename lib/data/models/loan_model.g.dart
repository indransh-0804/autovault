// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoanModelImpl _$$LoanModelImplFromJson(Map<String, dynamic> json) =>
    _$LoanModelImpl(
      id: json['id'] as String,
      purchaseId: json['purchaseId'] as String,
      customerId: json['customerId'] as String,
      principalAmount: (json['principalAmount'] as num).toDouble(),
      interestRate: (json['interestRate'] as num).toDouble(),
      termMonths: (json['termMonths'] as num).toInt(),
      processingFee: (json['processingFee'] as num?)?.toDouble() ?? 5000,
      emiAmount: (json['emiAmount'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      repaymentSchedule: (json['repaymentSchedule'] as List<dynamic>?)
              ?.map((e) =>
                  RepaymentEntryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$LoanStatusEnumMap, json['status']) ??
          LoanStatus.active,
      guarantorName: json['guarantorName'] as String? ?? '',
      guarantorPhone: json['guarantorPhone'] as String? ?? '',
      guarantorRelationship: json['guarantorRelationship'] as String? ?? '',
    );

Map<String, dynamic> _$$LoanModelImplToJson(_$LoanModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'purchaseId': instance.purchaseId,
      'customerId': instance.customerId,
      'principalAmount': instance.principalAmount,
      'interestRate': instance.interestRate,
      'termMonths': instance.termMonths,
      'processingFee': instance.processingFee,
      'emiAmount': instance.emiAmount,
      'startDate': instance.startDate.toIso8601String(),
      'repaymentSchedule': instance.repaymentSchedule,
      'status': _$LoanStatusEnumMap[instance.status]!,
      'guarantorName': instance.guarantorName,
      'guarantorPhone': instance.guarantorPhone,
      'guarantorRelationship': instance.guarantorRelationship,
    };

const _$LoanStatusEnumMap = {
  LoanStatus.active: 'active',
  LoanStatus.closed: 'closed',
  LoanStatus.overdue: 'overdue',
};
