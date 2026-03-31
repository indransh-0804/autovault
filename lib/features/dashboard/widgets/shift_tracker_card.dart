import 'package:autovault/core/utils/size_config.dart';
import 'package:autovault/features/dashboard/widgets/quick_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:autovault/features/dashboard/providers/dashboard_provider.dart';
import 'package:go_router/go_router.dart';

class ShiftTrackerCard extends ConsumerStatefulWidget {
  const ShiftTrackerCard({super.key});

  @override
  ConsumerState<ShiftTrackerCard> createState() => _ShiftTrackerCardState();
}

class _ShiftTrackerCardState extends ConsumerState<ShiftTrackerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _showEndShiftSheet(BuildContext context) {
    final shift = ref.read(shiftProvider);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _EndShiftBottomSheet(
        elapsed: shift.formattedElapsedShort,
        salesCount: shift.salesDuringShift,
        onConfirm: () {
          ref.read(shiftProvider.notifier).endShift();
          Navigator.of(ctx).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final shift = ref.watch(shiftProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(SizeConfig.w(12)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.w(16)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: shift.isActive
              ? [
                  cs.surfaceContainerHigh,
                  cs.surfaceContainerHighest.withValues(alpha: 0.7)
                ]
              : [
                  cs.surfaceContainerHigh.withValues(alpha: 0.7),
                  cs.surfaceContainerHighest.withValues(alpha: 0.4)
                ],
        ),
        border: Border.all(
          color: shift.isActive
              ? cs.primary.withValues(alpha: 0.4)
              : cs.outlineVariant.withValues(alpha: 0.4),
          width: shift.isActive ? 1.5 : 1,
        ),
        boxShadow: [
          if (shift.isActive)
            BoxShadow(
              color: cs.primary.withValues(alpha: 0.1),
              blurRadius: SizeConfig.w(24),
              spreadRadius: 2,
            ),
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.2),
            blurRadius: SizeConfig.w(12),
            offset: Offset(0, SizeConfig.h(4)),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Top row ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  color: shift.isActive ? cs.primary : cs.outline,
                  size: SizeConfig.w(20),
                ),
                SizedBox(width: SizeConfig.w(8)),
                Text(
                  'Shift Tracker',
                  style: tt.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ]),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.w(8),
                  vertical: SizeConfig.h(4),
                ),
                decoration: BoxDecoration(
                  color: shift.isActive
                      ? cs.primary.withValues(alpha: 0.15)
                      : cs.outline.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(SizeConfig.w(8)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: SizeConfig.w(8),
                      height: SizeConfig.w(8),
                      decoration: BoxDecoration(
                        color: shift.isActive ? cs.primary : cs.outline,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: SizeConfig.w(4)),
                    Text(
                      shift.isActive ? 'On Shift' : 'Off Shift',
                      style: tt.labelSmall?.copyWith(
                        color: shift.isActive ? cs.primary : cs.outline,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: SizeConfig.h(20)),

          // ── Center: timer or summary ──
          if (shift.isActive) ...[
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _pulseAnimation.value,
                  child: Text(
                    shift.formattedElapsed,
                    style: tt.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.primary,
                      letterSpacing: 2,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: SizeConfig.h(4)),
            Text(
              'Clocked in at ${shift.startTime != null ? '${shift.startTime!.hour.toString().padLeft(2, '0')}:${shift.startTime!.minute.toString().padLeft(2, '0')}' : '--:--'}',
              style: tt.labelSmall?.copyWith(color: cs.outline),
            ),
          ] else ...[
            Text(
              shift.totalHoursWorkedToday,
              style: tt.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: cs.onSurfaceVariant,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: SizeConfig.h(4)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history_rounded,
                    size: SizeConfig.w(12), color: cs.outline),
                SizedBox(width: SizeConfig.w(4)),
                Text(
                  'Last shift: ${shift.lastShiftSummary}',
                  style: tt.labelSmall?.copyWith(color: cs.outline),
                ),
              ],
            ),
          ],

          SizedBox(height: SizeConfig.h(20)),

          // ── Button ──
          SizedBox(
            width: double.infinity,
            height: SizeConfig.h(48),
            child: ElevatedButton(
              onPressed: () {
                if (shift.isActive) {
                  _showEndShiftSheet(context);
                } else {
                  ref.read(shiftProvider.notifier).startShift();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    shift.isActive ? cs.errorContainer : cs.primaryContainer,
                foregroundColor: cs.onPrimaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.w(12)),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    shift.isActive
                        ? Icons.stop_circle_rounded
                        : Icons.play_circle_filled_rounded,
                    size: SizeConfig.w(20),
                  ),
                  SizedBox(width: SizeConfig.w(8)),
                  Text(
                    shift.isActive ? 'End Shift' : 'Start Shift',
                    style: tt.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: SizeConfig.h(4)),
          SizedBox(child: Divider()),
          SizedBox(height: SizeConfig.h(4)),

          Row(
            children: [
              QuickActionButton(
                icon: Icons.point_of_sale_rounded,
                label: 'New Sale',
                onTap: () => context.push("/purchases/new"),
              ),
              SizedBox(width: SizeConfig.w(8)),
              QuickActionButton(
                icon: Icons.calendar_month_rounded,
                label: 'Test Drive',
                onTap: () => context.push("/test-drives"),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.h(8)),
          Row(
            children: [
              QuickActionButton(
                icon: Icons.person_add_alt_1_rounded,
                label: 'Customer',
                onTap: () => context.push("/customers"),
              ),
              SizedBox(width: SizeConfig.w(8)),
              QuickActionButton(
                icon: Icons.inventory_2_rounded,
                label: 'Inventory',
                onTap: () => context.push("/inventory"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EndShiftBottomSheet extends StatelessWidget {
  final String elapsed;
  final int salesCount;
  final VoidCallback onConfirm;

  const _EndShiftBottomSheet({
    required this.elapsed,
    required this.salesCount,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SizeConfig.w(24)),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        SizeConfig.w(24),
        SizeConfig.h(12),
        SizeConfig.w(24),
        SizeConfig.h(32),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: SizeConfig.w(40),
            height: SizeConfig.h(4),
            decoration: BoxDecoration(
              color: cs.outline.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(SizeConfig.w(2)),
            ),
          ),
          SizedBox(height: SizeConfig.h(24)),
          Container(
            padding: EdgeInsets.all(SizeConfig.w(16)),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle_rounded,
                color: cs.primary, size: SizeConfig.w(40)),
          ),
          SizedBox(height: SizeConfig.h(20)),
          Text(
            'End Your Shift?',
            style: tt.titleLarge?.copyWith(
              color: cs.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: SizeConfig.h(8)),
          Text(
            'Here\'s a summary of your shift today',
            style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          ),
          SizedBox(height: SizeConfig.h(28)),
          Container(
            padding: EdgeInsets.all(SizeConfig.w(20)),
            decoration: BoxDecoration(
              color: cs.surfaceContainer,
              borderRadius: BorderRadius.circular(SizeConfig.w(16)),
              border:
                  Border.all(color: cs.outlineVariant.withValues(alpha: 0.4)),
            ),
            child: Row(children: [
              _summaryItem(context, Icons.timer_rounded, 'Hours Worked',
                  elapsed, cs.secondary),
              Container(
                  width: 1,
                  height: SizeConfig.h(48),
                  color: cs.outlineVariant.withValues(alpha: 0.4)),
              _summaryItem(context, Icons.directions_car_rounded, 'Sales Made',
                  '$salesCount', cs.primary),
            ]),
          ),
          SizedBox(height: SizeConfig.h(28)),
          SizedBox(
            width: double.infinity,
            height: SizeConfig.h(52),
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primaryContainer,
                foregroundColor: cs.onPrimaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.w(12)),
                ),
                elevation: 0,
              ),
              child: Text(
                'Confirm End Shift',
                style: tt.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.3),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.h(12)),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Keep Working',
              style: tt.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(BuildContext context, IconData icon, String label,
      String value, Color color) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Expanded(
      child: Column(children: [
        Icon(icon, color: color, size: SizeConfig.w(20)),
        SizedBox(height: SizeConfig.h(8)),
        Text(value,
            style: tt.titleMedium
                ?.copyWith(fontWeight: FontWeight.w800, color: cs.onSurface)),
        SizedBox(height: SizeConfig.h(4)),
        Text(label, style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
      ]),
    );
  }
}
