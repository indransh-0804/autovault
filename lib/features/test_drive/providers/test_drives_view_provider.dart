// features/test_drives/providers/test_drives_view_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TestDriveView { calendar, timeline, list }

final testDrivesViewProvider = StateProvider<TestDriveView>(
  (_) => TestDriveView.calendar,
);

// features/test_drives/providers/selected_day_provider.dart
// (combined in same file for brevity)

final selectedDayProvider = StateProvider<DateTime>(
  (_) => DateTime.now(),
);

// Calendar month navigation
final calendarMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month);
});
