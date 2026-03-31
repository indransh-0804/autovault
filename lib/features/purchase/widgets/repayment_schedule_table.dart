// features/purchases/widgets/repayment_schedule_table.dart

import 'package:flutter/material.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/repayment_entry_model.dart';

class RepaymentScheduleTable extends StatelessWidget {
  const RepaymentScheduleTable({
    super.key,
    required this.schedule,
    this.previewRows = 6,
  });

  final List<RepaymentEntryModel> schedule;
  final int previewRows;

  @override
  Widget build(BuildContext context) {
    final theme   = Theme.of(context);
    final cs      = theme.colorScheme;
    final preview = schedule.take(previewRows).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header row ──────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withOpacity(0.2),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              _HeaderCell('Mo.', flex: 1, theme: theme, cs: cs),
              _HeaderCell('Due Date', flex: 3, theme: theme, cs: cs),
              _HeaderCell('EMI', flex: 3, theme: theme, cs: cs),
              _HeaderCell('Principal', flex: 3, theme: theme, cs: cs),
              _HeaderCell('Interest', flex: 3, theme: theme, cs: cs),
              _HeaderCell('Balance', flex: 3, theme: theme, cs: cs),
            ],
          ),
        ),

        // ── Preview rows ─────────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: cs.outline.withOpacity(0.1)),
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: preview.length,
            itemBuilder: (_, i) => _DataRow(
              entry: preview[i],
              isEven: i.isEven,
              theme: theme,
              cs: cs,
            ),
          ),
        ),

        // ── Expand button ─────────────────────────────────────────────────
        if (schedule.length > previewRows)
          TextButton(
            onPressed: () => _showFullSchedule(context, schedule),
            child: Text(
              'View all ${schedule.length} months →',
              style: TextStyle(
                  color: cs.primary, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }

  void _showFullSchedule(
      BuildContext context, List<RepaymentEntryModel> schedule) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (_, ctrl) => Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: cs.onSurfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                children: [
                  Text('Full Repayment Schedule',
                      style: theme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),
            const Divider(),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  _HeaderCell('Mo.', flex: 1, theme: theme, cs: cs),
                  _HeaderCell('Due Date', flex: 3, theme: theme, cs: cs),
                  _HeaderCell('EMI', flex: 3, theme: theme, cs: cs),
                  _HeaderCell('Principal', flex: 3, theme: theme, cs: cs),
                  _HeaderCell('Interest', flex: 3, theme: theme, cs: cs),
                  _HeaderCell('Balance', flex: 3, theme: theme, cs: cs),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: ctrl,
                itemCount: schedule.length,
                itemBuilder: (_, i) => _DataRow(
                  entry: schedule[i],
                  isEven: i.isEven,
                  theme: theme,
                  cs: cs,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text,
      {required this.flex, required this.theme, required this.cs});
  final String text;
  final int flex;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Expanded(
        flex: flex,
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: theme.textTheme.labelSmall!.copyWith(
            color: cs.primary,
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
        ),
      );
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.entry,
    required this.isEven,
    required this.theme,
    required this.cs,
  });
  final RepaymentEntryModel entry;
  final bool isEven;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        color: isEven
            ? cs.surfaceVariant.withOpacity(0.15)
            : Colors.transparent,
        child: Row(
          children: [
            _Cell('${entry.month}', flex: 1, theme: theme, cs: cs),
            _Cell(dateFormatter.format(entry.dueDate),
                flex: 3, theme: theme, cs: cs),
            _Cell(_fmt(entry.emiAmount), flex: 3, theme: theme, cs: cs),
            _Cell(_fmt(entry.principalComponent),
                flex: 3, theme: theme, cs: cs),
            _Cell(_fmt(entry.interestComponent),
                flex: 3, theme: theme, cs: cs),
            _Cell(_fmt(entry.remainingBalance),
                flex: 3, theme: theme, cs: cs,
                color: cs.onSurface.withOpacity(0.5)),
          ],
        ),
      );

  String _fmt(double v) => inrFormatter.format(v.round());
}

class _Cell extends StatelessWidget {
  const _Cell(this.text,
      {required this.flex, required this.theme, required this.cs, this.color});
  final String text;
  final int flex;
  final ThemeData theme;
  final ColorScheme cs;
  final Color? color;

  @override
  Widget build(BuildContext context) => Expanded(
        flex: flex,
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: theme.textTheme.labelSmall!.copyWith(
            color: color ?? cs.onSurface.withOpacity(0.8),
            fontSize: 10,
          ),
        ),
      );
}
