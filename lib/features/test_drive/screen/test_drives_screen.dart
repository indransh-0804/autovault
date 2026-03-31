import 'package:autovault/data/models/test_drive_model.dart';
import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:autovault/features/test_drive/providers/test_drives_provider.dart';
import 'package:autovault/features/test_drive/providers/test_drives_view_provider.dart';
import 'package:autovault/features/test_drive/widgets/add_edit_test_drive_sheet.dart';
import 'package:autovault/features/test_drive/widgets/calendar_widget.dart';
import 'package:autovault/features/test_drive/widgets/test_drive_card.dart';
import 'package:autovault/features/test_drive/widgets/timeline_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestDrivesScreen extends ConsumerStatefulWidget {
  const TestDrivesScreen({super.key});

  @override
  ConsumerState<TestDrivesScreen> createState() => _TestDrivesScreenState();
}

class _TestDrivesScreenState extends ConsumerState<TestDrivesScreen> {
  void _openScheduleSheet({TestDrivePrefill? prefill}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEditTestDriveSheet(prefill: prefill),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final view = ref.watch(testDrivesViewProvider);
    final isOwner = ref.watch(currentUserProvider)!.isOwner;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text('Test Drives',
            style: theme.textTheme.titleLarge!
                .copyWith(fontWeight: FontWeight.w800)),
      ),
      body: Column(
        children: [
          // ── View toggle ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: _ViewToggle(
              current: view,
              onChanged: (v) =>
                  ref.read(testDrivesViewProvider.notifier).state = v,
              cs: cs,
              theme: theme,
            ),
          ),

          // ── Content ──────────────────────────────────────────────────
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: switch (view) {
                TestDriveView.calendar => KeyedSubtree(
                    key: const ValueKey('calendar'),
                    child: SingleChildScrollView(
                      child: CalendarWidget(isOwner: isOwner),
                    ),
                  ),
                TestDriveView.timeline => KeyedSubtree(
                    key: const ValueKey('timeline'),
                    child: TimelineView(isOwner: isOwner),
                  ),
                TestDriveView.list => KeyedSubtree(
                    key: const ValueKey('list'),
                    child: _ListView(isOwner: isOwner),
                  ),
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openScheduleSheet,
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        icon: const Icon(Icons.calendar_month_rounded),
        label: const Text('Schedule',
            style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

// ─── View toggle ──────────────────────────────────────────────────────────────

class _ViewToggle extends StatelessWidget {
  const _ViewToggle({
    required this.current,
    required this.onChanged,
    required this.cs,
    required this.theme,
  });

  final TestDriveView current;
  final void Function(TestDriveView) onChanged;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: cs.surfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: TestDriveView.values.map((v) {
          final selected = v == current;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(v),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: selected ? cs.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Text(
                    switch (v) {
                      TestDriveView.calendar => 'Calendar',
                      TestDriveView.timeline => 'Timeline',
                      TestDriveView.list => 'List',
                    },
                    style: theme.textTheme.labelMedium!.copyWith(
                      color: selected
                          ? cs.onPrimary
                          : cs.onSurface.withOpacity(0.6),
                      fontWeight:
                          selected ? FontWeight.w700 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── List view ────────────────────────────────────────────────────────────────

class _ListView extends ConsumerStatefulWidget {
  const _ListView({required this.isOwner});
  final bool isOwner;

  @override
  ConsumerState<_ListView> createState() => _ListViewState();
}

class _ListViewState extends ConsumerState<_ListView> {
  final _searchCtr = TextEditingController();
  String _query = '';
  String _filter = 'All';

  static const _filters = [
    'All',
    'Today',
    'Upcoming',
    'Completed',
    'Cancelled'
  ];

  @override
  void dispose() {
    _searchCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final now = DateTime.now();
    var all = ref.watch(testDrivesNotifierProvider);

    // Apply filter
    all = switch (_filter) {
      'Today' => all
          .where((td) =>
              td.scheduledAt.year == now.year &&
              td.scheduledAt.month == now.month &&
              td.scheduledAt.day == now.day)
          .toList(),
      'Upcoming' => all
          .where((td) => td.scheduledAt.isAfter(now) && td.status.isActive)
          .toList(),
      'Completed' =>
        all.where((td) => td.status == TestDriveStatus.completed).toList(),
      'Cancelled' =>
        all.where((td) => td.status == TestDriveStatus.cancelled).toList(),
      _ => all,
    };

    // Apply search
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      all = all
          .where((td) =>
              td.customerName.toLowerCase().contains(q) ||
              td.carModel.toLowerCase().contains(q) ||
              td.carMake.toLowerCase().contains(q))
          .toList();
    }

    all.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

    return Column(
      children: [
        // Search
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: TextField(
            controller: _searchCtr,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search by customer or car…',
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        _searchCtr.clear();
                        setState(() => _query = '');
                      },
                    )
                  : null,
              filled: true,
              fillColor: cs.surfaceVariant.withOpacity(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Filter chips
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filters.length,
            itemBuilder: (_, i) {
              final f = _filters[i];
              final sel = f == _filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(f),
                  selected: sel,
                  onSelected: (_) => setState(() => _filter = f),
                  selectedColor: cs.primary,
                  backgroundColor: Colors.transparent,
                  labelStyle: TextStyle(
                    color: sel ? cs.onPrimary : cs.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  side: BorderSide(
                    color: sel ? cs.primary : cs.outline.withOpacity(0.4),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 4),

        // List
        Expanded(
          child: all.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.directions_car_outlined,
                          size: 48, color: cs.onSurface.withOpacity(0.2)),
                      const SizedBox(height: 12),
                      Text('No test drives found',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: cs.onSurface.withOpacity(0.4))),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: all.length,
                  itemBuilder: (_, i) => TestDriveCard(
                    testDrive: all[i],
                    isOwner: widget.isOwner,
                  ),
                ),
        ),
      ],
    );
  }
}
