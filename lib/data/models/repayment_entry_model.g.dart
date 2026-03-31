// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repayment_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepaymentEntryModelImpl _$$RepaymentEntryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RepaymentEntryModelImpl(
      month: (json['month'] as num).toInt(),
      dueDate: DateTime.parse(json['dueDate'] as String),
      emiAmount: (json['emiAmount'] as num).toDouble(),
      principalComponent: (json['principalComponent'] as num).toDouble(),
      interestComponent: (json['interestComponent'] as num).toDouble(),
      remainingBalance: (json['remainingBalance'] as num).toDouble(),
      isPaid: json['isPaid'] as bool? ?? false,
    );

Map<String, dynamic> _$$RepaymentEntryModelImplToJson(
        _$RepaymentEntryModelImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'dueDate': instance.dueDate.toIso8601String(),
      'emiAmount': instance.emiAmount,
      'principalComponent': instance.principalComponent,
      'interestComponent': instance.interestComponent,
      'remainingBalance': instance.remainingBalance,
      'isPaid': instance.isPaid,
    };
