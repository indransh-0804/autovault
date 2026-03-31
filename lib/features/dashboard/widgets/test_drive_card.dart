import 'package:autovault/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:autovault/data/models/dashboard_models.dart';

class TestDriveCard extends StatelessWidget {
  final TestDriveSchedule schedule;
  final bool isLast;

  const TestDriveCard({super.key, required this.schedule, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: SizeConfig.w(12),
                height: SizeConfig.w(12),
                decoration: BoxDecoration(
                  color: cs.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: cs.primary.withValues(alpha: 0.3),
                    width: 3,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: SizeConfig.w(2),
                    color: cs.primary.withValues(alpha: 0.2),
                  ),
                ),
            ],
          ),
          SizedBox(width: SizeConfig.w(12)),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: SizeConfig.h(16)),
              padding: EdgeInsets.all(SizeConfig.w(12)),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(SizeConfig.w(12)),
                border: Border.all(
                  color: cs.outlineVariant.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schedule.customerName,
                          style: tt.bodySmall?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeConfig.h(4)),
                        Text(
                          schedule.carModel,
                          style: tt.labelSmall?.copyWith(
                            color: cs.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: SizeConfig.h(4)),
                        Text(
                          'Assigned: ${schedule.assignedEmployee}',
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
                      color: cs.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(SizeConfig.w(8)),
                    ),
                    child: Text(
                      schedule.time,
                      style: tt.labelSmall?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

