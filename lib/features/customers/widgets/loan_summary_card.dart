// features/customers/widgets/loan_summary_card.dart

import 'package:flutter/material.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/mock/customer_mock_data.dart';

/// Displays a compact loan summary for a customer.
/// Reads from mockLoanSummaries for now — wire to loansProvider when built.
class LoanSummaryCard extends StatelessWidget {
  const LoanSummaryCard({super.key, required this.loanId});

  final String loanId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    // TODO: Replace with ref.watch(loanByIdProvider(loanId)) when loansProvider is built
    final loan = mockLoanSummaries.where((l) => l.loanId == loanId).firstOrNull;

    if (loan == null) return const SizedBox.shrink();

    final progress = loan.repaymentProgress.clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.primaryContainer.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.account_balance_rounded,
                  size: 18, color: cs.primary),
              const SizedBox(width: 8),
              Text(
                loan.bankName,
                style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: cs.primary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xFF4CAF50).withOpacity(0.5)),
                ),
                child: Text(
                  'Active',
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Amounts row
          Row(
            children: [
              _AmountCol(
                label: 'Total Loan',
                value: inrFormatter.format(loan.totalAmount),
                theme: theme,
                cs: cs,
              ),
              const SizedBox(width: 16),
              _AmountCol(
                label: 'Paid',
                value: inrFormatter.format(loan.amountPaid),
                theme: theme,
                cs: cs,
                valueColor: const Color(0xFF4CAF50),
              ),
              const SizedBox(width: 16),
              _AmountCol(
                label: 'Remaining',
                value: inrFormatter.format(loan.amountRemaining),
                theme: theme,
                cs: cs,
                valueColor: const Color(0xFFF44336),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: cs.outline.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(progress * 100).toStringAsFixed(0)}% repaid',
                style: theme.textTheme.labelSmall!.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Next due: ${dateFormatter.format(loan.nextDueDate)}',
                style: theme.textTheme.labelSmall!.copyWith(
                  color: cs.onSurface.withOpacity(0.5),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AmountCol extends StatelessWidget {
  const _AmountCol({
    required this.label,
    required this.value,
    required this.theme,
    required this.cs,
    this.valueColor,
  });

  final String label;
  final String value;
  final ThemeData theme;
  final ColorScheme cs;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall!.copyWith(
                color: cs.onSurface.withOpacity(0.45),
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: theme.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: valueColor ?? cs.onSurface,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
}
