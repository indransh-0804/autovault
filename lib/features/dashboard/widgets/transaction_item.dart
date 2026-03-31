import 'package:autovault/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:autovault/data/models/dashboard_models.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem({super.key, required this.transaction});

  Color _statusColor(BuildContext context) => switch (transaction.status) {
        TransactionStatus.paid => Theme.of(context).colorScheme.primary,
        TransactionStatus.loan => Theme.of(context).colorScheme.secondary,
        TransactionStatus.pending => Theme.of(context).colorScheme.tertiary,
      };

  String _statusLabel() => switch (transaction.status) {
        TransactionStatus.paid => 'PAID',
        TransactionStatus.loan => 'LOAN',
        TransactionStatus.pending => 'PENDING',
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final sc = _statusColor(context);

    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.h(8)),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.w(12), vertical: SizeConfig.h(12)),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(SizeConfig.w(12)),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(children: [
        Container(
          width: SizeConfig.w(40),
          height: SizeConfig.w(40),
          decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(SizeConfig.w(8))),
          child: Center(
              child: Text(
                  transaction.customerName.split(' ').map((e) => e[0]).join(),
                  style: tt.labelMedium?.copyWith(
                      color: cs.primary, fontWeight: FontWeight.w700))),
        ),
        SizedBox(width: SizeConfig.w(12)),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(transaction.customerName,
              style: tt.bodySmall
                  ?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w600)),
          SizedBox(height: SizeConfig.h(2)),
          Text(transaction.carModel,
              style: tt.labelSmall?.copyWith(color: cs.outline)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(transaction.amount,
              style: tt.bodySmall
                  ?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w700)),
          SizedBox(height: SizeConfig.h(4)),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.w(8), vertical: SizeConfig.h(4)),
            decoration: BoxDecoration(
                color: sc.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(SizeConfig.w(8))),
            child: Text(_statusLabel(),
                style: tt.labelSmall?.copyWith(
                    color: sc,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5)),
          ),
        ]),
      ]),
    );
  }
}
