import 'package:autovault/core/theme/theme.dart';
import 'package:autovault/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:autovault/data/models/dashboard_models.dart';
import 'glass_card.dart';

class LoanOverviewBar extends StatelessWidget {
  final LoanOverview data;

  const LoanOverviewBar({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GlassCard(
      gradient: AppColors.loansGradient,
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.h(16),
        horizontal: SizeConfig.w(12),
      ),
      child: Row(
        children: [
          _buildItem(
            context,
            icon: Icons.receipt_long_rounded,
            label: 'Active Loans',
            value: '${data.totalActiveLoans}',
            color: cs.secondary,
          ),
          _divider(cs),
          _buildItem(
            context,
            icon: Icons.payments_rounded,
            label: 'Collected',
            value: data.amountCollected,
            color: cs.primary,
          ),
          _divider(cs),
          _buildItem(
            context,
            icon: Icons.warning_amber_rounded,
            label: 'Overdue',
            value: '${data.overdueLoans}',
            color: cs.error,
            highlight: true,
          ),
        ],
      ),
    );
  }

  Widget _divider(ColorScheme cs) {
    return Container(
      width: 1,
      height: SizeConfig.h(40),
      color: cs.outlineVariant.withValues(alpha: 0.3),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool highlight = false,
  }) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: SizeConfig.w(20)),
          SizedBox(height: SizeConfig.h(8)),
          Text(
            value,
            style: tt.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          SizedBox(height: SizeConfig.h(4)),
          Text(
            label,
            style: tt.labelSmall?.copyWith(
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
