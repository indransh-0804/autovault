import 'package:autovault/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:autovault/data/models/dashboard_models.dart';

class CustomerTile extends StatelessWidget {
  final EmployeeCustomer customer;
  final VoidCallback? onTap;

  const CustomerTile({super.key, required this.customer, this.onTap});

  Color _statusColor(BuildContext context) => switch (customer.leadStatus) {
        CustomerLeadStatus.hotLead => Theme.of(context).colorScheme.error,
        CustomerLeadStatus.followUp => Theme.of(context).colorScheme.secondary,
        CustomerLeadStatus.converted => Theme.of(context).colorScheme.primary,
      };

  String _statusLabel() => switch (customer.leadStatus) {
        CustomerLeadStatus.hotLead => 'HOT LEAD',
        CustomerLeadStatus.followUp => 'FOLLOW-UP',
        CustomerLeadStatus.converted => 'CONVERTED',
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final sc = _statusColor(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.h(8)),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.w(12),
          vertical: SizeConfig.h(12),
        ),
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
              color: sc.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(SizeConfig.w(8)),
            ),
            child: Center(
              child: Text(
                customer.name.split(' ').map((e) => e[0]).join(),
                style: tt.labelMedium?.copyWith(
                  color: sc,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: SizeConfig.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: tt.bodySmall?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: SizeConfig.h(2)),
                Text(
                  'Last contact: ${customer.lastInteraction}',
                  style: tt.labelSmall?.copyWith(color: cs.outline),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.w(8),
              vertical: SizeConfig.h(4),
            ),
            decoration: BoxDecoration(
              color: sc.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(SizeConfig.w(8)),
            ),
            child: Text(
              _statusLabel(),
              style: tt.labelSmall?.copyWith(
                color: sc,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(width: SizeConfig.w(4)),
          Icon(
            Icons.chevron_right_rounded,
            color: cs.outline.withValues(alpha: 0.5),
            size: SizeConfig.w(20),
          ),
        ]),
      ),
    );
  }
}
