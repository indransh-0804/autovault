import 'dart:math';
import 'package:autovault/core/utils/app_constants.dart';
import 'package:autovault/data/models/add_on_model.dart';
import 'package:autovault/data/models/car_model.dart';
import 'package:autovault/data/models/customer_model.dart';
import 'package:autovault/data/models/purchase_model.dart';
import 'package:autovault/data/models/repayment_entry_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'purchase_form_provider.g.dart';

// ─── Loan config sub-state ────────────────────────────────────────────────────

class LoanConfig {
  final double loanAmount;
  final double interestRate;
  final int termMonths;
  final double processingFee;
  final DateTime startDate;
  final String guarantorName;
  final String guarantorPhone;
  final String guarantorRelationship;

  const LoanConfig({
    required this.loanAmount,
    this.interestRate = AppConstants.defaultInterestRate,
    this.termMonths = AppConstants.defaultLoanTermMonths,
    this.processingFee = AppConstants.defaultProcessingFee,
    DateTime? startDate,
    this.guarantorName = '',
    this.guarantorPhone = '',
    this.guarantorRelationship = '',
  }) : startDate = startDate ?? const _Now();

  LoanConfig copyWith({
    double? loanAmount,
    double? interestRate,
    int? termMonths,
    double? processingFee,
    DateTime? startDate,
    String? guarantorName,
    String? guarantorPhone,
    String? guarantorRelationship,
  }) =>
      LoanConfig(
        loanAmount: loanAmount ?? this.loanAmount,
        interestRate: interestRate ?? this.interestRate,
        termMonths: termMonths ?? this.termMonths,
        processingFee: processingFee ?? this.processingFee,
        startDate: startDate ?? this.startDate,
        guarantorName: guarantorName ?? this.guarantorName,
        guarantorPhone: guarantorPhone ?? this.guarantorPhone,
        guarantorRelationship:
            guarantorRelationship ?? this.guarantorRelationship,
      );

  // EMI = P × r × (1+r)^n / ((1+r)^n - 1)
  double get emiAmount {
    if (loanAmount <= 0 || termMonths <= 0) return 0;
    final r = interestRate / 12 / 100;
    if (r == 0) return loanAmount / termMonths;
    final factor = pow(1 + r, termMonths);
    return loanAmount * r * factor / (factor - 1);
  }

  double get totalInterest => (emiAmount * termMonths) - loanAmount;
  double get totalPayable => loanAmount + totalInterest + processingFee;

  List<RepaymentEntryModel> get repaymentSchedule {
    final schedule = <RepaymentEntryModel>[];
    final r = interestRate / 12 / 100;
    double balance = loanAmount;
    final emi = emiAmount;

    for (int m = 1; m <= termMonths; m++) {
      final interestComp = balance * r;
      final principalComp = emi - interestComp;
      balance = (balance - principalComp).clamp(0, double.infinity);

      schedule.add(RepaymentEntryModel(
        month: m,
        dueDate: DateTime(startDate.year, startDate.month + m, startDate.day),
        emiAmount: emi,
        principalComponent: principalComp,
        interestComponent: interestComp,
        remainingBalance: balance,
      ));
    }
    return schedule;
  }
}

// Hack to allow const default startDate
class _Now implements DateTime {
  const _Now();
  @override
  dynamic noSuchMethod(Invocation i) => DateTime.now();
}

// ─── Form state ───────────────────────────────────────────────────────────────

class PurchaseFormState {
  final int currentStep;
  final CustomerModel? selectedCustomer;
  final CarModel? selectedCar;
  final List<AddOnModel> selectedAddOns;
  final bool discountEnabled;
  final DiscountType discountType;
  final double discountValue;
  final PaymentMethod paymentMethod;
  final double downPayment;
  final LoanConfig? loanConfig;

  const PurchaseFormState({
    this.currentStep = 0,
    this.selectedCustomer,
    this.selectedCar,
    this.selectedAddOns = const [],
    this.discountEnabled = false,
    this.discountType = DiscountType.flat,
    this.discountValue = 0,
    this.paymentMethod = PaymentMethod.fullPayment,
    this.downPayment = 0,
    this.loanConfig,
  });

  PurchaseFormState copyWith({
    int? currentStep,
    CustomerModel? selectedCustomer,
    bool clearCustomer = false,
    CarModel? selectedCar,
    bool clearCar = false,
    List<AddOnModel>? selectedAddOns,
    bool? discountEnabled,
    DiscountType? discountType,
    double? discountValue,
    PaymentMethod? paymentMethod,
    double? downPayment,
    LoanConfig? loanConfig,
    bool clearLoan = false,
  }) =>
      PurchaseFormState(
        currentStep: currentStep ?? this.currentStep,
        selectedCustomer:
            clearCustomer ? null : selectedCustomer ?? this.selectedCustomer,
        selectedCar: clearCar ? null : selectedCar ?? this.selectedCar,
        selectedAddOns: selectedAddOns ?? this.selectedAddOns,
        discountEnabled: discountEnabled ?? this.discountEnabled,
        discountType: discountType ?? this.discountType,
        discountValue: discountValue ?? this.discountValue,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        downPayment: downPayment ?? this.downPayment,
        loanConfig: clearLoan ? null : loanConfig ?? this.loanConfig,
      );

  // ── Computed ───────────────────────────────────────────────────────────────

  double get carBasePrice => selectedCar?.sellingPrice ?? 0;
  double get addOnsTotal => selectedAddOns.fold(0, (s, a) => s + a.price);

  double get discountAmount {
    if (!discountEnabled || discountValue <= 0) return 0;
    return discountType == DiscountType.flat
        ? discountValue
        : carBasePrice * discountValue / 100;
  }

  double get subtotal =>
      (carBasePrice + addOnsTotal - discountAmount).clamp(0, double.infinity);
  double get gstAmount => subtotal * AppConstants.automobileGstRate;
  double get totalAmount => subtotal + gstAmount;

  double get loanAmount {
    if (paymentMethod == PaymentMethod.fullPayment) return 0;
    return (totalAmount - downPayment).clamp(0, double.infinity);
  }

  double get emiAmount => loanConfig?.emiAmount ?? 0;

  bool get requiresLoanStep =>
      paymentMethod == PaymentMethod.loan ||
      paymentMethod == PaymentMethod.partPayment;

  // Total steps: 0=Customer, 1=Car, 2=SaleDetails, 3=LoanConfig(if needed), 4=Review
  int get totalSteps => requiresLoanStep ? 5 : 4;
}

// ─── Notifier ─────────────────────────────────────────────────────────────────

@riverpod
class PurchaseFormNotifier extends _$PurchaseFormNotifier {
  @override
  PurchaseFormState build() => const PurchaseFormState();

  void reset() => state = const PurchaseFormState();

  void goToStep(int step) => state = state.copyWith(currentStep: step);

  void nextStep() {
    final next = state.currentStep + 1;
    // Skip loan step if not needed
    if (!state.requiresLoanStep && next == 3) {
      state = state.copyWith(currentStep: next + 1);
    } else {
      state = state.copyWith(currentStep: next);
    }
  }

  void prevStep() {
    final prev = state.currentStep - 1;
    if (!state.requiresLoanStep && prev == 3) {
      state = state.copyWith(currentStep: prev - 1);
    } else {
      state = state.copyWith(currentStep: prev);
    }
  }

  // ── Step 1 ─────────────────────────────────────────────────────────────────

  void selectCustomer(CustomerModel c) =>
      state = state.copyWith(selectedCustomer: c);

  void clearCustomer() => state = state.copyWith(clearCustomer: true);

  // ── Step 2 ─────────────────────────────────────────────────────────────────

  void selectCar(CarModel c) => state = state.copyWith(selectedCar: c);

  void clearCar() => state = state.copyWith(clearCar: true);

  // ── Step 3 ─────────────────────────────────────────────────────────────────

  void toggleAddOn(AddOnModel addOn) {
    final list = [...state.selectedAddOns];
    final idx = list.indexWhere((a) => a.id == addOn.id);
    if (idx >= 0) {
      list.removeAt(idx);
    } else {
      list.add(addOn);
    }
    state = state.copyWith(selectedAddOns: list);
  }

  void addCustomAddOn(AddOnModel addOn) {
    state = state.copyWith(selectedAddOns: [...state.selectedAddOns, addOn]);
  }

  void setDiscountEnabled(bool v) => state = state.copyWith(discountEnabled: v);

  void setDiscountType(DiscountType t) =>
      state = state.copyWith(discountType: t);

  void setDiscountValue(double v) => state = state.copyWith(discountValue: v);

  void setPaymentMethod(PaymentMethod m) {
    state = state.copyWith(
      paymentMethod: m,
      downPayment: 0,
    );
    // Auto-init loan config when loan/part selected
    if (m == PaymentMethod.loan || m == PaymentMethod.partPayment) {
      _refreshLoanConfig();
    } else {
      state = state.copyWith(clearLoan: true);
    }
  }

  void setDownPayment(double v) {
    state = state.copyWith(downPayment: v);
    _refreshLoanConfig();
  }

  void _refreshLoanConfig() {
    final amount = state.loanAmount;
    final existing = state.loanConfig;
    state = state.copyWith(
      loanConfig: LoanConfig(
        loanAmount: amount,
        interestRate:
            existing?.interestRate ?? AppConstants.defaultInterestRate,
        termMonths: existing?.termMonths ?? AppConstants.defaultLoanTermMonths,
        processingFee:
            existing?.processingFee ?? AppConstants.defaultProcessingFee,
        startDate: existing?.startDate ?? DateTime.now(),
        guarantorName: existing?.guarantorName ?? '',
        guarantorPhone: existing?.guarantorPhone ?? '',
        guarantorRelationship: existing?.guarantorRelationship ?? '',
      ),
    );
  }

  // ── Step 4 ─────────────────────────────────────────────────────────────────

  void updateLoanConfig(LoanConfig config) =>
      state = state.copyWith(loanConfig: config);

  void setInterestRate(double r) =>
      _updateLoan((c) => c.copyWith(interestRate: r));

  void setTermMonths(int t) => _updateLoan((c) => c.copyWith(termMonths: t));

  void setProcessingFee(double f) =>
      _updateLoan((c) => c.copyWith(processingFee: f));

  void setLoanStartDate(DateTime d) =>
      _updateLoan((c) => c.copyWith(startDate: d));

  void setGuarantor(String name, String phone, String rel) =>
      _updateLoan((c) => c.copyWith(
            guarantorName: name,
            guarantorPhone: phone,
            guarantorRelationship: rel,
          ));

  void _updateLoan(LoanConfig Function(LoanConfig) fn) {
    final current = state.loanConfig;
    if (current == null) return;
    state = state.copyWith(loanConfig: fn(current));
  }
}
