// features/purchases/purchase_form_screen.dart

import 'package:autovault/data/models/purchase_model.dart';
import 'package:autovault/features/purchase/providers/purchases_provider.dart';
import 'package:autovault/features/purchase/widgets/customer_selector.dart';
import 'package:autovault/features/purchase/widgets/loan_config_step.dart';
import 'package:autovault/features/purchase/widgets/price_breakdown_panel.dart';
import 'package:autovault/features/purchase/widgets/review_confirm_step.dart';
import 'package:autovault/features/purchase/widgets/sale_details_step.dart'
    show SaleDetailsStep;
import 'package:autovault/features/purchase/widgets/step_indicator.dart';
import 'package:autovault/features/purchase/providers/purchase_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/car_selector.dart';

const _stepLabels = ['Customer', 'Vehicle', 'Sale Details', 'Loan', 'Review'];

// Step indices
const _kCustomer = 0;
const _kCar = 1;
const _kSaleDetails = 2;
const _kLoan = 3;
const _kReview = 4;

class PurchaseFormScreen extends ConsumerStatefulWidget {
  const PurchaseFormScreen({super.key});

  @override
  ConsumerState<PurchaseFormScreen> createState() => _PurchaseFormScreenState();
}

class _PurchaseFormScreenState extends ConsumerState<PurchaseFormScreen> {
  bool _isSubmitting = false;
  String? _stepError;
  late final PageController _pageCtrl;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController();
    // Reset form on open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(purchaseFormNotifierProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    final notifier = ref.read(purchaseFormNotifierProvider.notifier);
    notifier.goToStep(step);
    _pageCtrl.animateToPage(
      step,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
    );
    setState(() => _stepError = null);
  }

  void _next() {
    final form = ref.read(purchaseFormNotifierProvider);
    final notifier = ref.read(purchaseFormNotifierProvider.notifier);

    final err = _validate(form.currentStep, form);
    if (err != null) {
      setState(() => _stepError = err);
      return;
    }
    setState(() => _stepError = null);

    final nextStep = _computeNextStep(form);
    notifier.goToStep(nextStep);
    _pageCtrl.animateToPage(
      nextStep,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
    );
  }

  void _back() {
    final form = ref.read(purchaseFormNotifierProvider);
    final notifier = ref.read(purchaseFormNotifierProvider.notifier);

    if (form.currentStep == 0) {
      _showDiscardDialog();
      return;
    }

    final prevStep = _computePrevStep(form);
    notifier.goToStep(prevStep);
    _pageCtrl.animateToPage(
      prevStep,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
    );
    setState(() => _stepError = null);
  }

  int _computeNextStep(PurchaseFormState form) {
    final cur = form.currentStep;
    if (cur == _kSaleDetails && !form.requiresLoanStep) return _kReview;
    return cur + 1;
  }

  int _computePrevStep(PurchaseFormState form) {
    final cur = form.currentStep;
    if (cur == _kReview && !form.requiresLoanStep) return _kSaleDetails;
    return cur - 1;
  }

  String? _validate(int step, PurchaseFormState form) {
    return switch (step) {
      _kCustomer => form.selectedCustomer == null
          ? 'Please select a customer to continue.'
          : null,
      _kCar => form.selectedCar == null
          ? 'Please select a vehicle to continue.'
          : null,
      _kSaleDetails => _validateSaleDetails(form),
      _ => null,
    };
  }

  String? _validateSaleDetails(PurchaseFormState form) {
    if (form.paymentMethod == PaymentMethod.partPayment) {
      if (form.downPayment <= 0) {
        return 'Enter a down payment amount for Part Payment.';
      }
      if (form.downPayment >= form.totalAmount) {
        return 'Down payment must be less than the total amount.';
      }
    }
    if (form.discountEnabled && form.discountAmount > form.carBasePrice) {
      return 'Discount cannot exceed the car\'s selling price.';
    }
    return null;
  }

  // ── Discard dialog ─────────────────────────────────────────────────────────

  Future<void> _showDiscardDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Discard Sale?'),
        content:
            const Text('All entered information will be lost. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep Editing'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      ref.read(purchaseFormNotifierProvider.notifier).reset();
      context.pop();
    }
  }

  // ── Submit ─────────────────────────────────────────────────────────────────

  Future<void> _submit() async {
    final form = ref.read(purchaseFormNotifierProvider);
    if (form.selectedCustomer == null || form.selectedCar == null) return;

    setState(() => _isSubmitting = true);

    try {
      final car = form.selectedCar!;
      final customer = form.selectedCustomer!;
      final now = DateTime.now();
      final purchaseId = 'sale_${now.millisecondsSinceEpoch}';

      // Build loan if applicable
      String? loanId;
      if (form.requiresLoanStep && form.loanConfig != null) {
        loanId = 'loan_${now.millisecondsSinceEpoch}';
        // loansProvider.createLoan(LoanModel(...)) — wire when loansProvider is built
      }

      final purchase = PurchaseModel(
        id: purchaseId,
        customerId: customer.id,
        customerName: customer.fullName,
        carDetails: CarSnapshot(
          carId: car.id,
          make: car.make,
          model: car.model,
          year: car.year,
          vin: car.vin,
          color: car.color,
          sellingPrice: car.sellingPrice,
        ),
        employeeId: 'emp_001', // TODO: from auth provider
        employeeName: 'Rohan Sharma',
        addOns: form.selectedAddOns,
        discountType: form.discountType,
        discountValue: form.discountValue,
        subtotal: form.subtotal,
        gstAmount: form.gstAmount,
        totalAmount: form.totalAmount,
        paymentMethod: form.paymentMethod,
        downPayment: form.downPayment,
        loanId: loanId,
        status: PurchaseStatus.completed,
        createdAt: now,
      );

      await ref
          .read(purchasesNotifierProvider.notifier)
          .createPurchase(purchase);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎉  Sale confirmed!'),
          backgroundColor: Color(0xFF4CAF50),
          duration: Duration(seconds: 3),
        ),
      );

      ref.read(purchaseFormNotifierProvider.notifier).reset();
      context.go('/employee_dashboard');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
          action: SnackBarAction(
            label: 'Retry',
            onPressed: _submit,
            textColor: Colors.white,
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final form = ref.watch(purchaseFormNotifierProvider);
    final isReview = form.currentStep == _kReview;

    // Skipped steps set — loan step skipped when full payment
    final skipped = form.requiresLoanStep ? <int>{} : {_kLoan};

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        backgroundColor: cs.background,
        appBar: AppBar(
          backgroundColor: cs.surface,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: _showDiscardDialog,
          ),
          title: Text(
            isReview ? 'Review & Confirm' : 'New Sale',
            style: theme.textTheme.titleLarge!
                .copyWith(fontWeight: FontWeight.w800),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(76),
            child: PurchaseStepIndicator(
              steps: _stepLabels,
              currentStep: form.currentStep,
              skippedSteps: skipped,
              onStepTap: _goToStep,
            ),
          ),
        ),
        body: Column(
          children: [
            // ── Step content ─────────────────────────────────────────
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Step 0 — Customer
                  _StepShell(
                    child: CustomerSelector(
                      onAddNew: () {
                        // Open AddEditCustomerSheet
                        // showModalBottomSheet(... AddEditCustomerSheet)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Wire AddEditCustomerSheet from customers feature here'),
                          ),
                        );
                      },
                    ),
                  ),

                  // Step 1 — Car
                  const _StepShell(child: CarSelector()),

                  // Step 2 — Sale Details
                  _StepShell(
                    bottomPanel: const PriceBreakdownPanel(),
                    child: const SaleDetailsStep(),
                  ),

                  // Step 3 — Loan Config
                  const _StepShell(child: LoanConfigStep()),

                  // Step 4 — Review
                  _StepShell(
                    child: ReviewConfirmStep(
                      onConfirm: _submit,
                      isLoading: _isSubmitting,
                    ),
                  ),
                ],
              ),
            ),

            // ── Error message ─────────────────────────────────────────
            if (_stepError != null)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: cs.errorContainer,
                child: Row(
                  children: [
                    Icon(Icons.error_outline_rounded,
                        size: 16, color: cs.onErrorContainer),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _stepError!,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: cs.onErrorContainer),
                      ),
                    ),
                  ],
                ),
              ),

            // ── Bottom nav buttons (hidden on review — review has its own button) ──
            if (!isReview)
              _BottomNavBar(
                step: form.currentStep,
                onBack: _back,
                onNext: _next,
                theme: theme,
                cs: cs,
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Step shell — scrollable content wrapper ──────────────────────────────────

class _StepShell extends StatelessWidget {
  const _StepShell({required this.child, this.bottomPanel});
  final Widget child;
  final Widget? bottomPanel;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: child,
            ),
          ),
          if (bottomPanel != null) bottomPanel!,
        ],
      );
}

// ─── Bottom navigation bar ────────────────────────────────────────────────────

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.step,
    required this.onBack,
    required this.onNext,
    required this.theme,
    required this.cs,
  });
  final int step;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.fromLTRB(
            16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
        decoration: BoxDecoration(
          color: cs.surface,
          border: Border(top: BorderSide(color: cs.outline.withOpacity(0.12))),
        ),
        child: Row(
          children: [
            if (step > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: cs.outline.withOpacity(0.4)),
                    foregroundColor: cs.onSurface,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Back',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              )
            else
              const Spacer(),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: onNext,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  'Continue',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
