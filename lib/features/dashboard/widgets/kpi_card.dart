import 'package:flutter/material.dart';
import 'package:autovault/core/utils/size_config.dart';
import 'package:autovault/data/models/dashboard_models.dart';
import 'glass_card.dart';

class KpiCard extends StatelessWidget {
  final KpiMetric metric;
  final List<Color> gradient;

  const KpiCard({super.key, required this.metric, required this.gradient});

  IconData _icon() {
    switch (metric.iconName) {
      case 'revenue':
        return Icons.account_balance_wallet_rounded;
      case 'cars_sold':
        return Icons.directions_car_rounded;
      case 'loans':
        return Icons.receipt_long_rounded;
      case 'test_drives':
        return Icons.speed_rounded;
      default:
        return Icons.analytics_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return GlassCard(
      width: SizeConfig.w(168),
      gradient: gradient,
      padding: EdgeInsets.all(SizeConfig.w(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.w(8)),
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(SizeConfig.w(8)),
                ),
                child: Icon(_icon(), color: cs.primary, size: SizeConfig.w(20)),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.w(8),
                  vertical: SizeConfig.h(4),
                ),
                decoration: BoxDecoration(
                  color: (metric.isPositive ? cs.tertiary : cs.error)
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(SizeConfig.w(8)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      metric.isPositive
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      size: SizeConfig.w(12),
                      color: metric.isPositive ? cs.tertiary : cs.error,
                    ),
                    SizedBox(width: SizeConfig.w(2)),
                    Text(
                      metric.changePercent,
                      style: tt.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: metric.isPositive ? cs.tertiary : cs.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.h(16)),
          Text(
            metric.value,
            style: tt.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
            ),
          ),
          SizedBox(height: SizeConfig.h(4)),
          Text(
            metric.title,
            style: tt.labelSmall?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
