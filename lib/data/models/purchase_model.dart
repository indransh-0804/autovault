// data/models/purchase_model.dart
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'add_on_model.dart';

part 'purchase_model.freezed.dart';
part 'purchase_model.g.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

enum DiscountType {
  @JsonValue('flat')       flat,
  @JsonValue('percentage') percentage,
}

enum PaymentMethod {
  @JsonValue('full_payment') fullPayment,
  @JsonValue('loan')         loan,
  @JsonValue('part_payment') partPayment,
}

enum PurchaseStatus {
  @JsonValue('completed') completed,
  @JsonValue('voided')    voided,
}

extension PaymentMethodX on PaymentMethod {
  String get label => switch (this) {
        PaymentMethod.fullPayment => 'Full Payment',
        PaymentMethod.loan        => 'Loan / EMI',
        PaymentMethod.partPayment => 'Part Payment',
      };
}

extension PurchaseStatusX on PurchaseStatus {
  String get label => this == PurchaseStatus.completed ? 'Completed' : 'Voided';
}

// ─── Embedded car snapshot ────────────────────────────────────────────────────

@freezed
class CarSnapshot with _$CarSnapshot {
  const factory CarSnapshot({
    required String carId,
    required String make,
    required String model,
    required int year,
    required String vin,
    required String color,
    required double sellingPrice,
  }) = _CarSnapshot;

  factory CarSnapshot.fromJson(Map<String, dynamic> json) =>
      _$CarSnapshotFromJson(json);
}

// ─── PurchaseModel ────────────────────────────────────────────────────────────

@freezed
class PurchaseModel with _$PurchaseModel {
  const PurchaseModel._();

  const factory PurchaseModel({
    required String id,
    required String customerId,
    required String customerName,
    required CarSnapshot carDetails,
    required String employeeId,
    required String employeeName,
    @Default([]) List<AddOnModel> addOns,
    @Default(DiscountType.flat) DiscountType discountType,
    @Default(0) double discountValue,
    required double subtotal,
    required double gstAmount,
    @Default(0.28) double gstRate,
    required double totalAmount,
    @Default(PaymentMethod.fullPayment) PaymentMethod paymentMethod,
    @Default(0) double downPayment,
    String? loanId,
    @Default(PurchaseStatus.completed) PurchaseStatus status,
    required DateTime createdAt,
  }) = _PurchaseModel;

  // Computed
  double get addOnsTotal =>
      addOns.fold(0, (sum, a) => sum + a.price);

  double get loanAmount =>
      paymentMethod == PaymentMethod.fullPayment
          ? 0
          : totalAmount - downPayment;

  factory PurchaseModel.fromJson(Map<String, dynamic> json) =>
      _$PurchaseModelFromJson(json);
}
