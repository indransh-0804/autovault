// data/models/repayment_entry_model.dart
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'repayment_entry_model.freezed.dart';
part 'repayment_entry_model.g.dart';

@freezed
class RepaymentEntryModel with _$RepaymentEntryModel {
  const factory RepaymentEntryModel({
    required int month,
    required DateTime dueDate,
    required double emiAmount,
    required double principalComponent,
    required double interestComponent,
    required double remainingBalance,
    @Default(false) bool isPaid,
  }) = _RepaymentEntryModel;

  factory RepaymentEntryModel.fromJson(Map<String, dynamic> json) =>
      _$RepaymentEntryModelFromJson(json);
}
