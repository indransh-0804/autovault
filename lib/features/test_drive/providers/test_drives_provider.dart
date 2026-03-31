// features/test_drives/providers/test_drives_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/mock/test_drives_mock_data.dart';
import '../../../data/models/test_drive_activity_model.dart';
import '../../../data/models/test_drive_model.dart';

part 'test_drives_provider.g.dart';

// ─── Notifier ─────────────────────────────────────────────────────────────────

@riverpod
class TestDrivesNotifier extends _$TestDrivesNotifier {
  @override
  List<TestDriveModel> build() => List.from(mockTestDrives);

  // ── CRUD ──────────────────────────────────────────────────────────────────

  void scheduleTestDrive(TestDriveModel td) {
    state = [td, ...state];
    // TODO: also update customersProvider.addTestDriveId(td.customerId, td.id)
  }

  void updateTestDrive(TestDriveModel updated) {
    state = [
      for (final td in state)
        if (td.id == updated.id) updated else td,
    ];
  }

  void updateStatus(
    String id,
    TestDriveStatus status, {
    String? note,
  }) {
    state = [
      for (final td in state)
        if (td.id == id)
          td.copyWith(
            status: status,
            activityLog: [
              ...td.activityLog,
              TestDriveActivityModel(
                id:          'act_${DateTime.now().millisecondsSinceEpoch}',
                timestamp:   DateTime.now(),
                description: note ?? 'Status changed to ${status.label}.',
                type:        TestDriveActivityType.statusChanged,
              ),
            ],
          )
        else
          td,
    ];
  }

  void cancelTestDrive(String id, {String reason = 'Cancelled'}) {
    updateStatus(id, TestDriveStatus.cancelled, note: reason);
  }

  void markConverted(String id, String purchaseId) {
    state = [
      for (final td in state)
        if (td.id == id)
          td.copyWith(
            convertedToPurchaseId: purchaseId,
            activityLog: [
              ...td.activityLog,
              TestDriveActivityModel(
                id:          'act_${DateTime.now().millisecondsSinceEpoch}',
                timestamp:   DateTime.now(),
                description: 'Converted to sale — purchase $purchaseId created.',
                type:        TestDriveActivityType.converted,
              ),
            ],
          )
        else
          td,
    ];
  }

  void addNote(String id, String note) {
    state = [
      for (final td in state)
        if (td.id == id)
          td.copyWith(
            notes: note,
            activityLog: [
              ...td.activityLog,
              TestDriveActivityModel(
                id:          'act_${DateTime.now().millisecondsSinceEpoch}',
                timestamp:   DateTime.now(),
                description: 'Note added: $note',
                type:        TestDriveActivityType.noted,
              ),
            ],
          )
        else
          td,
    ];
  }
}

// ─── View filters ─────────────────────────────────────────────────────────────

@riverpod
List<TestDriveModel> testDrivesByDate(
    TestDrivesByDateRef ref, DateTime date) {
  return ref.watch(testDrivesNotifierProvider).where((td) {
    final s = td.scheduledAt;
    return s.year == date.year &&
        s.month == date.month &&
        s.day == date.day;
  }).toList()
    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
}

@riverpod
List<TestDriveModel> testDrivesByCustomer(
    TestDrivesByCustomerRef ref, String customerId) {
  return ref
      .watch(testDrivesNotifierProvider)
      .where((td) => td.customerId == customerId)
      .toList()
    ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
}

@riverpod
List<TestDriveModel> testDrivesByEmployee(
    TestDrivesByEmployeeRef ref, String employeeId) {
  return ref
      .watch(testDrivesNotifierProvider)
      .where((td) => td.assignedEmployeeId == employeeId)
      .toList()
    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
}

@riverpod
List<TestDriveModel> upcomingTestDrives(UpcomingTestDrivesRef ref) {
  final now = DateTime.now();
  return ref
      .watch(testDrivesNotifierProvider)
      .where((td) =>
          td.scheduledAt.isAfter(now) && td.status.isActive)
      .toList()
    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
}

@riverpod
List<TestDriveModel> todaysTestDrives(TodaysTestDrivesRef ref) {
  final now = DateTime.now();
  return ref.watch(testDrivesNotifierProvider).where((td) {
    final s = td.scheduledAt;
    return s.year == now.year &&
        s.month == now.month &&
        s.day == now.day;
  }).toList()
    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
}

// ─── Conflict detection ───────────────────────────────────────────────────────
// Returns the first conflicting TestDriveModel, or null if clear.
// A conflict = same car, active status, within [scheduledAt, scheduledAt + duration + 60min].

@riverpod
TestDriveModel? conflictingTestDrive(
  ConflictingTestDriveRef ref, {
  required String carId,
  required DateTime scheduledAt,
  required int durationMinutes,
  String? excludeId, // exclude the drive being edited
}) {
  final all = ref.watch(testDrivesNotifierProvider);
  final window = Duration(minutes: durationMinutes + 60);
  final rangeStart = scheduledAt.subtract(const Duration(minutes: 60));
  final rangeEnd   = scheduledAt.add(window);

  return all.where((td) {
    if (td.carId != carId) return false;
    if (td.id == excludeId) return false;
    if (td.status == TestDriveStatus.cancelled) return false;
    if (td.status == TestDriveStatus.completed) return false;
    return td.scheduledAt.isAfter(rangeStart) &&
        td.scheduledAt.isBefore(rangeEnd);
  }).firstOrNull;
}

// ─── Lookup by id ─────────────────────────────────────────────────────────────

@riverpod
TestDriveModel? testDriveById(TestDriveByIdRef ref, String id) {
  return ref
      .watch(testDrivesNotifierProvider)
      .where((td) => td.id == id)
      .firstOrNull;
}
