import 'package:autovault/data/models/test_drive_model.dart';
import 'package:autovault/features/test_drive/providers/test_drives_provider.dart';
import 'package:autovault/features/test_drive/widgets/test_drive_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineView extends ConsumerWidget {
  const TimelineView({super.key, required this.isOwner});
  final bool isOwner;

  Color _statusColor(TestDriveStatus s) => switch (s) {
        TestDriveStatus.confirmed => const Color(0xFF4CAF50),
        TestDriveStatus.inProgress => const Color(0xFF1E88E5),
        TestDriveStatus.pending => const Color(0xFFFFC107),
        TestDriveStatus.completed => const Color(0xFF9E9E9E),
        TestDriveStatus.cancelled => const Color(0xFFF44336),
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final allTds = ref.watch(testDrivesNotifierProvider);
    final now = DateTime.now();

    // Split into upcoming and past
    final upcoming = allTds
        .where((td) =>
            td.scheduledAt.isAfter(now) ||
            (td.scheduledAt.day == now.day &&
                td.scheduledAt.month == now.month &&
                td.scheduledAt.year == now.year))
        .toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

    final past = allTds
        .where((td) =>
            td.scheduledAt.isBefore(now) &&
            !(td.scheduledAt.day == now.day &&
                td.scheduledAt.month == now.month &&
                td.scheduledAt.year == now.year))
        .toList()
      ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));

    // Group upcoming by date
    final Map<String, List<TestDriveModel>> grouped = {};
    for (final td in upcoming) {
      final key = _dayKey(td.scheduledAt, now);
      grouped.putIfAbsent(key, () => []).add(td);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // ── Upcoming ──────────────────────────────────────────────────────
        if (grouped.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              children: [
                Icon(Icons.event_available_rounded,
                    size: 48, color: cs.onSurface.withOpacity(0.2)),
                const SizedBox(height: 12),
                Text('No upcoming test drives',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: cs.onSurface.withOpacity(0.4))),
              ],
            ),
          )
        else
          ...grouped.entries.expand((entry) => [
                // Day header
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: cs.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        entry.key,
                        style: theme.textTheme.labelMedium!.copyWith(
                          color: cs.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Divider(color: cs.outline.withOpacity(0.15))),
                    ],
                  ),
                ),
                // Drives for this day — timeline spine
                ...entry.value.asMap().entries.map((e) {
                  final td = e.value;
                  final isLast = e.key == entry.value.length - 1 &&
                      entry.key == grouped.keys.last;
                  return _TimelineItem(
                    testDrive: td,
                    isOwner: isOwner,
                    isLast: isLast,
                    dotColor: _statusColor(td.status),
                  );
                }),
              ]),

        // ── Past divider ──────────────────────────────────────────────────
        if (past.isNotEmpty) ...[
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Divider(color: cs.outline.withOpacity(0.15))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('PAST',
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: cs.onSurface.withOpacity(0.35),
                      letterSpacing: 1,
                    )),
              ),
              Expanded(child: Divider(color: cs.outline.withOpacity(0.15))),
            ],
          ),
          const SizedBox(height: 8),
          ...past.map((td) => Opacity(
                opacity: 0.6,
                child: TestDriveCard(testDrive: td, isOwner: isOwner),
              )),
        ],
      ],
    );
  }

  String _dayKey(DateTime date, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final d = DateTime(date.year, date.month, date.day);
    if (d == today) return 'TODAY';
    if (d == tomorrow) return 'TOMORROW';
    const days = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${days[date.weekday]}, ${date.day} ${months[date.month]}';
  }
}

// ─── Timeline item ────────────────────────────────────────────────────────────

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.testDrive,
    required this.isOwner,
    required this.isLast,
    required this.dotColor,
  });

  final TestDriveModel testDrive;
  final bool isOwner;
  final bool isLast;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Spine
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: dotColor.withOpacity(0.4),
                        blurRadius: 4,
                      )
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: cs.outline.withOpacity(0.15),
                    ),
                  ),
              ],
            ),
          ),

          // Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: TestDriveCard(
                testDrive: testDrive,
                isOwner: isOwner,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
