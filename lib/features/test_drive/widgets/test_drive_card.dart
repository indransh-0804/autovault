import 'package:autovault/data/models/test_drive_model.dart';
import 'package:autovault/features/shared/widgets/avatar_widget.dart';
import 'package:autovault/features/test_drive/providers/test_drives_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

final _timeFmt = DateFormat('h:mm a');
final _dateFmt = DateFormat('EEE, d MMM');

class TestDriveCard extends ConsumerWidget {
  const TestDriveCard({
    super.key,
    required this.testDrive,
    required this.isOwner,
    this.compact = false,
  });

  final TestDriveModel testDrive;
  final bool isOwner;
  final bool compact;

  Color _statusColor(TestDriveStatus s) => switch (s) {
        TestDriveStatus.pending => const Color(0xFFFFC107),
        TestDriveStatus.confirmed => const Color(0xFF4CAF50),
        TestDriveStatus.inProgress => const Color(0xFF1E88E5),
        TestDriveStatus.completed => const Color(0xFF9E9E9E),
        TestDriveStatus.cancelled => const Color(0xFFF44336),
      };

  void _showActionSheet(BuildContext ctx, WidgetRef ref) {
    final notifier = ref.read(testDrivesNotifierProvider.notifier);
    final td = testDrive;
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Theme.of(ctx).colorScheme.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color:
                    Theme.of(ctx).colorScheme.onSurfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(td.customerName,
                  style: Theme.of(ctx).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            const Divider(height: 24),
            _tile(ctx, Icons.edit_outlined, 'Edit', () {
              Navigator.pop(ctx);
              ctx.push('/test-drives/${td.id}');
            }),
            if (td.status == TestDriveStatus.pending)
              _tile(ctx, Icons.check_circle_outline, 'Confirm', () {
                notifier.updateStatus(td.id, TestDriveStatus.confirmed);
                Navigator.pop(ctx);
              }, color: const Color(0xFF4CAF50)),
            if (td.status.isActive)
              _tile(ctx, Icons.cancel_outlined, 'Cancel', () {
                notifier.cancelTestDrive(td.id);
                Navigator.pop(ctx);
              }, color: Theme.of(ctx).colorScheme.error),
            if (td.status == TestDriveStatus.completed &&
                td.convertedToPurchaseId == null)
              _tile(ctx, Icons.point_of_sale_rounded, 'Convert to Sale', () {
                Navigator.pop(ctx);
                ctx.push('/purchases/new', extra: {
                  'prefillCustomerId': td.customerId,
                  'prefillCarId': td.carId,
                  'testDriveId': td.id,
                });
              }, color: Theme.of(ctx).colorScheme.primary),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  ListTile _tile(
          BuildContext ctx, IconData icon, String label, VoidCallback onTap,
          {Color? color}) =>
      ListTile(
        leading: Icon(icon, color: color),
        title:
            Text(label, style: color != null ? TextStyle(color: color) : null),
        onTap: onTap,
        dense: true,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final td = testDrive;
    final sColor = _statusColor(td.status);
    final canAct = isOwner || true; // employee can act on assigned drives

    return GestureDetector(
      onTap: () => context.push('/test-drives/${td.id}', extra: td),
      onLongPress: !canAct ? null : () => _showActionSheet(context, ref),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outline.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            // Avatar
            AvatarWidget(name: td.customerName, radius: 22),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(td.customerName,
                            style: theme.textTheme.titleSmall!
                                .copyWith(fontWeight: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      // Status badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: sColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: sColor.withOpacity(0.5)),
                        ),
                        child: Text(td.status.label,
                            style: theme.textTheme.labelSmall!.copyWith(
                              color: sColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(td.carDisplayName,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: cs.onSurface.withOpacity(0.55))),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.schedule_rounded,
                              size: 12, color: cs.onSurface.withOpacity(0.4)),
                          const SizedBox(width: 4),
                          Text(
                            '${_dateFmt.format(td.scheduledAt)} · ${_timeFmt.format(td.scheduledAt)}',
                            style: theme.textTheme.labelSmall!
                                .copyWith(color: cs.onSurface.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.timer_outlined,
                              size: 12, color: cs.onSurface.withOpacity(0.4)),
                          const SizedBox(width: 3),
                          Text('${td.durationMinutes} min',
                              style: theme.textTheme.labelSmall!.copyWith(
                                  color: cs.onSurface.withOpacity(0.5))),
                        ],
                      ),
                      if (isOwner && td.assignedEmployeeName.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: cs.primaryContainer.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            td.assignedEmployeeName.split(' ').first,
                            style: theme.textTheme.labelSmall!.copyWith(
                              color: cs.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(width: 6),
            Icon(Icons.chevron_right_rounded,
                color: cs.onSurface.withOpacity(0.3), size: 18),
          ],
        ),
      ),
    );
  }
}
