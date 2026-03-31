import 'package:autovault/data/models/test_drive_activity_model.dart';
import 'package:autovault/data/models/test_drive_model.dart';
import 'package:autovault/features/test_drive/providers/test_drives_provider.dart';
import 'package:autovault/features/test_drive/widgets/add_edit_test_drive_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/formatters.dart';

final _timeFmt = DateFormat('h:mm a');

class TestDriveDetailScreen extends ConsumerStatefulWidget {
  const TestDriveDetailScreen({
    super.key,
    required this.testDriveId,
  });
  final String testDriveId;

  @override
  ConsumerState<TestDriveDetailScreen> createState() =>
      _TestDriveDetailScreenState();
}

class _TestDriveDetailScreenState extends ConsumerState<TestDriveDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  final _noteCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.4,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _noteCtr.dispose();
    super.dispose();
  }

  Color _statusColor(TestDriveStatus s) => switch (s) {
        TestDriveStatus.pending => const Color(0xFFFFC107),
        TestDriveStatus.confirmed => const Color(0xFF4CAF50),
        TestDriveStatus.inProgress => const Color(0xFF1E88E5),
        TestDriveStatus.completed => const Color(0xFF9E9E9E),
        TestDriveStatus.cancelled => const Color(0xFFF44336),
      };

  IconData _statusIcon(TestDriveStatus s) => switch (s) {
        TestDriveStatus.pending => Icons.schedule_rounded,
        TestDriveStatus.confirmed => Icons.check_circle_outline_rounded,
        TestDriveStatus.inProgress => Icons.directions_car_rounded,
        TestDriveStatus.completed => Icons.task_alt_rounded,
        TestDriveStatus.cancelled => Icons.cancel_outlined,
      };

  void _openEdit(BuildContext ctx, TestDriveModel td) {
    if (td.status.isClosed) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('This test drive is already closed.')),
      );
      return;
    }
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEditTestDriveSheet(existing: td),
    );
  }

  void _showNoteDialog(BuildContext ctx, TestDriveModel td) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: _noteCtr,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Write a note…'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (_noteCtr.text.trim().isNotEmpty) {
                ref
                    .read(testDrivesNotifierProvider.notifier)
                    .addNote(td.id, _noteCtr.text.trim());
                _noteCtr.clear();
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final td = ref.watch(testDriveByIdProvider(widget.testDriveId));

    if (td == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Test drive not found.')),
      );
    }

    final notifier = ref.read(testDrivesNotifierProvider.notifier);
    final sColor = _statusColor(td.status);
    final isPulsing = td.status == TestDriveStatus.pending ||
        td.status == TestDriveStatus.inProgress;

    return Scaffold(
      backgroundColor: cs.background,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(td.customerName,
            style: theme.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _openEdit(context, td),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Status banner ─────────────────────────────────────────────
            AnimatedBuilder(
              animation: _pulseCtrl,
              builder: (_, child) => Opacity(
                opacity: isPulsing ? _pulseCtrl.value : 1.0,
                child: child,
              ),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                color: sColor.withOpacity(0.12),
                child: Row(
                  children: [
                    Icon(_statusIcon(td.status), color: sColor, size: 26),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(td.status.label,
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: sColor,
                              fontWeight: FontWeight.w800,
                            )),
                        Text(
                          '${dateFormatter.format(td.scheduledAt)}  ·  ${_timeFmt.format(td.scheduledAt)}  ·  ${td.durationMinutes} min',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: sColor.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Core details card ──────────────────────────────────
                  _SectionTitle('Details', theme),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: cs.outline.withOpacity(0.15)),
                    ),
                    child: Column(
                      children: [
                        _DetailRow('Customer', td.customerName, theme, cs,
                            onTap: () =>
                                context.push('/customers/${td.customerId}')),
                        _DetailRow('Vehicle', td.carDisplayName, theme, cs,
                            onTap: () =>
                                context.push('/inventory/car/${td.carId}')),
                        _DetailRow(
                            'Scheduled',
                            '${dateFormatter.format(td.scheduledAt)}  at  ${_timeFmt.format(td.scheduledAt)}',
                            theme,
                            cs),
                        _DetailRow('Duration', '${td.durationMinutes} minutes',
                            theme, cs),
                        _DetailRow(
                            'Assigned To', td.assignedEmployeeName, theme, cs),
                        if (td.location.isNotEmpty)
                          _DetailRow(
                              'Route / Location', td.location, theme, cs),
                        if (td.notes.isNotEmpty)
                          _DetailRow('Notes', td.notes, theme, cs,
                              isLast: true),
                        if (td.convertedToPurchaseId != null)
                          _DetailRow('Converted to Sale',
                              td.convertedToPurchaseId!, theme, cs,
                              isLast: true,
                              valueColor: const Color(0xFF4CAF50)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Activity log ───────────────────────────────────────
                  _SectionTitle('Activity Log', theme),
                  const SizedBox(height: 12),
                  _ActivityTimeline(log: td.activityLog, theme: theme, cs: cs),
                  const SizedBox(height: 24),

                  // ── Action buttons ─────────────────────────────────────
                  _SectionTitle('Actions', theme),
                  const SizedBox(height: 12),
                  _ActionButtons(
                    td: td,
                    theme: theme,
                    cs: cs,
                    notifier: notifier,
                    onNote: () => _showNoteDialog(context, td),
                    onRebook: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => AddEditTestDriveSheet(existing: td),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Action buttons ───────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.td,
    required this.theme,
    required this.cs,
    required this.notifier,
    required this.onNote,
    required this.onRebook,
  });

  final TestDriveModel td;
  final ThemeData theme;
  final ColorScheme cs;
  final TestDrivesNotifier notifier;
  final VoidCallback onNote;
  final VoidCallback onRebook;

  @override
  Widget build(BuildContext context) {
    return switch (td.status) {
      TestDriveStatus.pending => Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () =>
                    notifier.updateStatus(td.id, TestDriveStatus.confirmed),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Confirm',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () => notifier.cancelTestDrive(td.id),
                style: OutlinedButton.styleFrom(
                  foregroundColor: cs.error,
                  side: BorderSide(color: cs.error.withOpacity(0.6)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Cancel',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      TestDriveStatus.confirmed => Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => notifier.updateStatus(
                    td.id, TestDriveStatus.inProgress,
                    note: 'Test drive started.'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Mark as In Progress',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onRebook,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFFFC107),
                      side: const BorderSide(color: Color(0xFFFFC107)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Reschedule',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => notifier.cancelTestDrive(td.id),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.error,
                      side: BorderSide(color: cs.error.withOpacity(0.6)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      TestDriveStatus.inProgress => Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () => notifier.updateStatus(
                    td.id, TestDriveStatus.completed,
                    note: 'Test drive completed successfully.'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Mark as Completed',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () => notifier.cancelTestDrive(td.id),
                style: OutlinedButton.styleFrom(
                  foregroundColor: cs.error,
                  side: BorderSide(color: cs.error.withOpacity(0.6)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Cancel',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      TestDriveStatus.completed => Column(
          children: [
            if (td.convertedToPurchaseId == null)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => context.push('/purchases/new', extra: {
                    'prefillCustomerId': td.customerId,
                    'prefillCarId': td.carId,
                    'testDriveId': td.id,
                  }),
                  icon: const Icon(Icons.point_of_sale_rounded),
                  label: const Text('Convert to Sale',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color(0xFF4CAF50).withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.task_alt_rounded,
                        color: Color(0xFF4CAF50), size: 18),
                    const SizedBox(width: 8),
                    Text('Converted to sale ${td.convertedToPurchaseId}',
                        style: const TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onNote,
                icon: const Icon(Icons.edit_note_rounded, size: 18),
                label: const Text('Write a Note',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      TestDriveStatus.cancelled => SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onRebook,
            icon: const Icon(Icons.event_repeat_rounded),
            label: const Text('Rebook',
                style: TextStyle(fontWeight: FontWeight.w700)),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
    };
  }
}

// ─── Activity timeline ────────────────────────────────────────────────────────

class _ActivityTimeline extends StatelessWidget {
  const _ActivityTimeline(
      {required this.log, required this.theme, required this.cs});

  final List<TestDriveActivityModel> log;
  final ThemeData theme;
  final ColorScheme cs;

  Color _typeColor(TestDriveActivityType t) => switch (t) {
        TestDriveActivityType.booked => const Color(0xFF1E88E5),
        TestDriveActivityType.confirmed => const Color(0xFF4CAF50),
        TestDriveActivityType.statusChanged => const Color(0xFFFFC107),
        TestDriveActivityType.rescheduled => const Color(0xFFFF7043),
        TestDriveActivityType.noted => const Color(0xFF9C27B0),
        TestDriveActivityType.cancelled => const Color(0xFFF44336),
        TestDriveActivityType.converted => const Color(0xFF4CAF50),
      };

  @override
  Widget build(BuildContext context) {
    if (log.isEmpty) {
      return Text('No activity yet.',
          style: theme.textTheme.bodySmall!
              .copyWith(color: cs.onSurface.withOpacity(0.4)));
    }

    final sorted = [...log]..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Column(
      children: sorted.asMap().entries.map((e) {
        final item = e.value;
        final isLast = e.key == sorted.length - 1;
        final tColor = _typeColor(item.type);

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 36,
                child: Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: tColor.withOpacity(0.12),
                        shape: BoxShape.circle,
                        border: Border.all(color: tColor.withOpacity(0.5)),
                      ),
                      child: Center(
                        child: Text(item.type.emoji,
                            style: const TextStyle(fontSize: 13)),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          color: cs.outline.withOpacity(0.15),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 16, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: tColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(item.type.label,
                                style: theme.textTheme.labelSmall!.copyWith(
                                  color: tColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                )),
                          ),
                          const Spacer(),
                          Text(
                            dateFormatter.format(item.timestamp),
                            style: theme.textTheme.labelSmall!.copyWith(
                              color: cs.onSurface.withOpacity(0.4),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(item.description,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: cs.onSurface.withOpacity(0.75),
                            height: 1.4,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, this.theme);
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Text(title,
      style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700));
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(
    this.label,
    this.value,
    this.theme,
    this.cs, {
    this.isLast = false,
    this.onTap,
    this.valueColor,
  });

  final String label;
  final String value;
  final ThemeData theme;
  final ColorScheme cs;
  final bool isLast;
  final VoidCallback? onTap;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(label,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: cs.onSurface.withOpacity(0.45),
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  Expanded(
                    child: Text(value,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: valueColor ??
                              (onTap != null
                                  ? cs.primary
                                  : cs.onSurface.withOpacity(0.85)),
                          decoration:
                              onTap != null ? TextDecoration.underline : null,
                        )),
                  ),
                ],
              ),
            ),
          ),
          if (!isLast) Divider(height: 1, color: cs.outline.withOpacity(0.1)),
        ],
      );
}
