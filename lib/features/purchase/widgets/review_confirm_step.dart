import 'package:autovault/data/models/car_model.dart';
import 'package:autovault/data/models/customer_model.dart';
import 'package:autovault/data/models/purchase_model.dart';
import 'package:autovault/features/purchase/providers/purchase_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatters.dart';

class ReviewConfirmStep extends ConsumerStatefulWidget {
  const ReviewConfirmStep({
    super.key,
    required this.onConfirm,
    required this.isLoading,
  });
  final VoidCallback onConfirm;
  final bool isLoading;

  @override
  ConsumerState<ReviewConfirmStep> createState() => _ReviewConfirmStepState();
}

class _ReviewConfirmStepState extends ConsumerState<ReviewConfirmStep> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final form = ref.watch(purchaseFormNotifierProvider);
    final customer = form.selectedCustomer;
    final car = form.selectedCar;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Customer card ─────────────────────────────────────────────
        _ReviewCard(
          title: 'Customer',
          icon: Icons.person_rounded,
          theme: theme,
          cs: cs,
          child: _InfoRows([
            ('Name', customer?.fullName ?? '—'),
            ('Phone', customer?.phone ?? '—'),
            if ((customer?.email ?? '').isNotEmpty) ('Email', customer!.email),
            ('Lead Status', customer?.leadStatus.label ?? '—'),
          ], theme, cs),
        ),
        const SizedBox(height: 12),

        // ── Car card ──────────────────────────────────────────────────
        _ReviewCard(
          title: 'Vehicle',
          icon: Icons.directions_car_rounded,
          theme: theme,
          cs: cs,
          child: _InfoRows([
            ('Make & Model', '${car?.make} ${car?.model}'),
            ('Year', '${car?.year}'),
            ('VIN', car?.vin ?? '—'),
            ('Color', car?.color ?? '—'),
            ('Condition', car?.condition.label ?? '—'),
            ('Fuel', car?.fuelType.label ?? '—'),
            ('Base Price', inrFormatter.format(car?.sellingPrice ?? 0)),
          ], theme, cs),
        ),
        const SizedBox(height: 12),

        // ── Sale details card ─────────────────────────────────────────
        _ReviewCard(
          title: 'Sale Details',
          icon: Icons.receipt_long_outlined,
          theme: theme,
          cs: cs,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (form.selectedAddOns.isNotEmpty) ...[
                Text('Add-ons',
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: cs.onSurface.withOpacity(0.45),
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 4),
                ...form.selectedAddOns.map(
                  (a) => Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('  · ${a.name}',
                            style: theme.textTheme.bodySmall!.copyWith(
                                color: cs.onSurface.withOpacity(0.7))),
                        Text(inrFormatter.format(a.price),
                            style: theme.textTheme.bodySmall!.copyWith(
                                color: cs.onSurface.withOpacity(0.7))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              _InfoRows([
                ('Payment Method', form.paymentMethod.label),
                if (form.discountAmount > 0)
                  ('Discount', '− ${inrFormatter.format(form.discountAmount)}'),
                ('Subtotal', inrFormatter.format(form.subtotal)),
                ('GST (28%)', inrFormatter.format(form.gstAmount)),
                ('Total Amount', inrFormatter.format(form.totalAmount)),
                if (form.paymentMethod == PaymentMethod.partPayment)
                  ('Down Payment', inrFormatter.format(form.downPayment)),
                if (form.requiresLoanStep)
                  ('Loan Amount', inrFormatter.format(form.loanAmount)),
              ], theme, cs, highlightLast: true),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Loan summary ──────────────────────────────────────────────
        if (form.requiresLoanStep && form.loanConfig != null) ...[
          _ReviewCard(
            title: 'Loan Summary',
            icon: Icons.account_balance_outlined,
            theme: theme,
            cs: cs,
            child: Column(
              children: [
                // Big EMI
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text('Monthly EMI',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: cs.onSurface.withOpacity(0.5))),
                      Text(
                        inrFormatter.format(form.loanConfig!.emiAmount.round()),
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: cs.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                _InfoRows([
                  ('Interest Rate', '${form.loanConfig!.interestRate}% p.a.'),
                  ('Term', '${form.loanConfig!.termMonths} months'),
                  (
                    'Processing Fee',
                    inrFormatter.format(form.loanConfig!.processingFee)
                  ),
                  (
                    'Start Date',
                    dateFormatter.format(form.loanConfig!.startDate)
                  ),
                  (
                    'Total Payable',
                    inrFormatter.format(form.loanConfig!.totalPayable.round())
                  ),
                ], theme, cs),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],

        // ── Terms checkbox ─────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _agreed
                  ? cs.primary.withOpacity(0.4)
                  : cs.outline.withOpacity(0.15),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v ?? false),
                activeColor: cs.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    'I confirm that all details above are accurate and the customer has agreed to the terms of this sale.',
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: cs.onSurface.withOpacity(0.75)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ── Confirm button ────────────────────────────────────────────
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: (_agreed && !widget.isLoading) ? widget.onConfirm : null,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              disabledBackgroundColor: cs.primary.withOpacity(0.3),
            ),
            child: widget.isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: cs.onPrimary,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_rounded, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Confirm Sale',
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: _agreed
                              ? cs.onPrimary
                              : cs.onPrimary.withOpacity(0.5),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.title,
    required this.icon,
    required this.child,
    required this.theme,
    required this.cs,
  });
  final String title;
  final IconData icon;
  final Widget child;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outline.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: cs.primary),
                const SizedBox(width: 6),
                Text(title,
                    style: theme.textTheme.labelMedium!.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    )),
              ],
            ),
            const SizedBox(height: 10),
            Divider(height: 1, color: cs.outline.withOpacity(0.1)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      );
}

class _InfoRows extends StatelessWidget {
  const _InfoRows(this.rows, this.theme, this.cs, {this.highlightLast = false});
  final List<(String, String)> rows;
  final ThemeData theme;
  final ColorScheme cs;
  final bool highlightLast;

  @override
  Widget build(BuildContext context) => Column(
        children: rows.asMap().entries.map((e) {
          final isLast = e.key == rows.length - 1;
          final highlight = isLast && highlightLast;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 110,
                  child: Text(e.value.$1,
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: cs.onSurface.withOpacity(0.45),
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Expanded(
                  child: Text(
                    e.value.$2,
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: highlight
                          ? cs.primary
                          : cs.onSurface.withOpacity(0.85),
                      fontWeight:
                          highlight ? FontWeight.w800 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
}
