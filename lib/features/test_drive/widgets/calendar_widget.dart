import 'package:autovault/data/models/test_drive_model.dart';
import 'package:autovault/features/test_drive/providers/test_drives_provider.dart';
import 'package:autovault/features/test_drive/providers/test_drives_view_provider.dart';
import 'package:autovault/features/test_drive/widgets/test_drive_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class CalendarWidget extends ConsumerStatefulWidget {
  const CalendarWidget({super.key, required this.isOwner});
  final bool isOwner;

  @override
  ConsumerState<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends ConsumerState<CalendarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideCtrl;
  bool _slidingRight = true;

  @override
  void initState() {
    super.initState();
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _slideCtrl.dispose();
    super.dispose();
  }

  void _changeMonth(int delta) {
    setState(() => _slidingRight = delta > 0);
    _slideCtrl.forward(from: 0);
    final current = ref.read(calendarMonthProvider);
    ref.read(calendarMonthProvider.notifier).state =
        DateTime(current.year, current.month + delta);
  }

  // Returns the day cells for the current month grid.
  // Index 0 = Monday, so we offset by weekday-1 (DateTime.weekday: Mon=1..Sun=7)
  List<DateTime?> _buildDayCells(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    // weekday: Mon=1, offset to make Mon=0
    final offset = (firstDay.weekday - 1) % 7;
    final cells = <DateTime?>[];
    for (int i = 0; i < offset; i++) cells.add(null);
    for (int d = 1; d <= daysInMonth; d++) {
      cells.add(DateTime(month.year, month.month, d));
    }
    // pad to complete last row
    while (cells.length % 7 != 0) cells.add(null);
    return cells;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final month = ref.watch(calendarMonthProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    final allDrives = ref.watch(testDrivesNotifierProvider);
    final cells = _buildDayCells(month);
    final today = DateTime.now();
    final drivesForSelected = ref.watch(testDrivesByDateProvider(selectedDay));

    // Build a quick lookup: day → list of drives
    final Map<int, List<TestDriveModel>> drivesByDay = {};
    for (final td in allDrives) {
      if (td.scheduledAt.year == month.year &&
          td.scheduledAt.month == month.month) {
        drivesByDay.putIfAbsent(td.scheduledAt.day, () => []).add(td);
      }
    }

    return Column(
      children: [
        // ── Month header ─────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded),
                onPressed: () => _changeMonth(-1),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 260),
                  transitionBuilder: (child, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(_slidingRight ? 0.3 : -0.3, 0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                        parent: animation, curve: Curves.easeOutCubic)),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                  child: Text(
                    '${_monthName(month.month)} ${month.year}',
                    key: ValueKey('${month.month}${month.year}'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded),
                onPressed: () => _changeMonth(1),
              ),
            ],
          ),
        ),

        // ── Weekday labels ───────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: _weekdays
                .map((d) => Expanded(
                      child: Text(d,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelSmall!.copyWith(
                            color: cs.onSurface.withOpacity(0.4),
                            fontWeight: FontWeight.w600,
                          )),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 4),

        // ── Day grid ─────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween<Offset>(
                begin: Offset(_slidingRight ? 0.15 : -0.15, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                  parent: animation, curve: Curves.easeOutCubic)),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: GridView.builder(
              key: ValueKey('${month.month}${month.year}'),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 0.85,
              ),
              itemCount: cells.length,
              itemBuilder: (_, i) {
                final date = cells[i];
                if (date == null) return const SizedBox.shrink();

                final isToday = date.year == today.year &&
                    date.month == today.month &&
                    date.day == today.day;
                final isSelected = date.year == selectedDay.year &&
                    date.month == selectedDay.month &&
                    date.day == selectedDay.day;
                final drives = drivesByDay[date.day] ?? [];

                return GestureDetector(
                  onTap: () =>
                      ref.read(selectedDayProvider.notifier).state = date,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Day number
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? cs.primary
                              : isToday
                                  ? cs.primary.withOpacity(0.15)
                                  : Colors.transparent,
                          border: isToday && !isSelected
                              ? Border.all(color: cs.primary.withOpacity(0.6))
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: isSelected
                                  ? cs.onPrimary
                                  : isToday
                                      ? cs.primary
                                      : cs.onSurface.withOpacity(0.8),
                              fontWeight: (isToday || isSelected)
                                  ? FontWeight.w700
                                  : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      // Dots
                      if (drives.isNotEmpty) _DotRow(drives: drives, cs: cs),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        // ── Selected day panel ────────────────────────────────────────────
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          height: drivesForSelected.isEmpty ? 80 : null,
          constraints: drivesForSelected.isNotEmpty
              ? const BoxConstraints(maxHeight: 300)
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  _dayLabel(selectedDay),
                  style: theme.textTheme.labelMedium!.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              if (drivesForSelected.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('No test drives on this day.',
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: cs.onSurface.withOpacity(0.4))),
                )
              else
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: drivesForSelected.length,
                    itemBuilder: (_, i) => TestDriveCard(
                      testDrive: drivesForSelected[i],
                      isOwner: widget.isOwner,
                      compact: true,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _monthName(int m) => const [
        '',
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ][m];

  String _dayLabel(DateTime d) {
    final now = DateTime.now();
    if (d.year == now.year && d.month == now.month && d.day == now.day) {
      return 'TODAY';
    }
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    if (d.year == tomorrow.year &&
        d.month == tomorrow.month &&
        d.day == tomorrow.day) {
      return 'TOMORROW';
    }
    return '${_weekdayName(d.weekday).toUpperCase()}, ${d.day} ${_monthName(d.month).substring(0, 3).toUpperCase()}';
  }

  String _weekdayName(int w) =>
      const ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][w];
}

// ─── Dot row ──────────────────────────────────────────────────────────────────

class _DotRow extends StatelessWidget {
  const _DotRow({required this.drives, required this.cs});
  final List<TestDriveModel> drives;
  final ColorScheme cs;

  Color _dotColor(TestDriveStatus s) => switch (s) {
        TestDriveStatus.confirmed => const Color(0xFF4CAF50),
        TestDriveStatus.inProgress => const Color(0xFF1E88E5),
        TestDriveStatus.pending => const Color(0xFFFFC107),
        TestDriveStatus.completed => const Color(0xFF9E9E9E),
        TestDriveStatus.cancelled => const Color(0xFFF44336),
      };

  @override
  Widget build(BuildContext context) {
    final show = drives.take(3).toList();
    final extra = drives.length - 3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...show.map((td) => Container(
              width: 5,
              height: 5,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _dotColor(td.status),
              ),
            )),
        if (extra > 0)
          Text('+',
              style: TextStyle(
                  color: cs.primary, fontSize: 8, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
