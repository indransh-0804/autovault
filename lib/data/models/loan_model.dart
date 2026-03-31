// data/models/loan_model.dart
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'repayment_entry_model.dart';

part 'loan_model.freezed.dart';
part 'loan_model.g.dart';

enum LoanStatus {
  @JsonValue('active')   active,
  @JsonValue('closed')   closed,
  @JsonValue('overdue')  overdue,
}

extension LoanStatusX on LoanStatus {
  String get label => switch (this) {
        LoanStatus.active  => 'Active',
        LoanStatus.closed  => 'Closed',
        LoanStatus.overdue => 'Overdue',
      };
}

@freezed
class LoanModel with _$LoanModel {
  const LoanModel._();

  const factory LoanModel({
    required String id,
    required String purchaseId,
    required String customerId,
    required double principalAmount,
    required double interestRate,
    required int termMonths,
    @Default(5000) double processingFee,
    required double emiAmount,
    required DateTime startDate,
    @Default([]) List<RepaymentEntryModel> repaymentSchedule,
    @Default(LoanStatus.active) LoanStatus status,
    @Default('') String guarantorName,
    @Default('') String guarantorPhone,
    @Default('') String guarantorRelationship,
  }) = _LoanModel;

  // Computed
  double get totalInterest =>
      (emiAmount * termMonths) - principalAmount;

  double get totalPayable =>
      principalAmount + totalInterest + processingFee;

  factory LoanModel.fromJson(Map<String, dynamic> json) =>
      _$LoanModelFromJson(json);
}
