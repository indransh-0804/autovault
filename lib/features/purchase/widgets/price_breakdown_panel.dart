import 'package:autovault/core/utils/formatters.dart';
import 'package:autovault/data/models/purchase_model.dart';
import 'package:autovault/features/purchase/providers/purchase_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceBreakdownPanel extends ConsumerWidget {
  const PriceBreakdownPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(purchaseFormNotifierProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isLoan = form.requiresLoanStep;
    final isPart = form.paymentMethod == PaymentMethod.partPayment;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(top: BorderSide(color: cs.outline.withOpacity(0.15))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Price Breakdown',
              style: theme.textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w700,
                color: cs.onSurface.withOpacity(0.6),
                letterSpacing: 0.6,
              )),
          const SizedBox(height: 10),
          _Row('Car Base Price', form.carBasePrice, theme, cs),
          if (form.addOnsTotal > 0)
            _Row('Add-ons', form.addOnsTotal, theme, cs, prefix: '+'),
          if (form.discountAmount > 0)
            _Row('Discount', form.discountAmount, theme, cs,
                prefix: '−', valueColor: const Color(0xFF4CAF50)),
          _Divider(cs),
          _Row('Subtotal', form.subtotal, theme, cs, bold: true),
          _Row('GST (28%)', form.gstAmount, theme, cs, prefix: '+'),
          _Divider(cs),
          _Row('Total Amount', form.totalAmount, theme, cs,
              bold: true, valueColor: cs.primary, large: true),
          if (isPart && form.downPayment > 0) ...[
            _Row('Down Payment', form.downPayment, theme, cs, prefix: '−'),
            _Divider(cs),
            _Row('Loan Amount', form.loanAmount, theme, cs,
                bold: true, valueColor: const Color(0xFF1E88E5)),
          ],
          if (isLoan && !isPart && form.loanAmount > 0) ...[
            _Divider(cs),
            _Row('Loan Amount', form.loanAmount, theme, cs,
                bold: true, valueColor: const Color(0xFF1E88E5)),
          ],
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(
    this.label,
    this.amount,
    this.theme,
    this.cs, {
    this.prefix = '',
    this.bold = false,
    this.large = false,
    this.valueColor,
  });

  final String label;
  final double amount;
  final ThemeData theme;
  final ColorScheme cs;
  final String prefix;
  final bool bold;
  final bool large;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: (large
                        ? theme.textTheme.bodyMedium
                        : theme.textTheme.bodySmall)!
                    .copyWith(
                  color: cs.onSurface.withOpacity(bold ? 0.85 : 0.55),
                  fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
            ),
            Text(
              '$prefix${inrFormatter.format(amount)}',
              style: (large
                      ? theme.textTheme.titleSmall
                      : theme.textTheme.bodySmall)!
                  .copyWith(
                color:
                    valueColor ?? cs.onSurface.withOpacity(bold ? 0.9 : 0.65),
                fontWeight: bold ? FontWeight.w800 : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
}

class _Divider extends StatelessWidget {
  const _Divider(this.cs);
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Divider(
        height: 12,
        color: cs.outline.withOpacity(0.15),
      );
}
