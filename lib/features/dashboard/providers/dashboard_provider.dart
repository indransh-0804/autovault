import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:autovault/data/models/dashboard_models.dart';
import 'package:autovault/data/mock/mock_data.dart';
import 'package:autovault/data/models/task_model.dart';
import 'package:autovault/data/mock/employee_mock_data.dart';
import 'dart:async';
import 'package:autovault/data/models/shift_model.dart';

class ShiftNotifier extends StateNotifier<ShiftState> {
  Timer? _timer;

  ShiftNotifier()
      : super(ShiftState(
          startTime: DateTime(2026, 3, 1, 9, 0),
          endTime: DateTime(2026, 3, 1, 17, 30),
          salesDuringShift: 3,
        ));

  void startShift() {
    state = ShiftState(
      isActive: true,
      startTime: DateTime.now(),
      elapsedDuration: Duration.zero,
      salesDuringShift: 0,
    );
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.isActive && state.startTime != null) {
        state = state.copyWith(
          elapsedDuration: DateTime.now().difference(state.startTime!),
        );
      }
    });
  }

  void endShift() {
    _timer?.cancel();
    _timer = null;
    state = state.copyWith(isActive: false, endTime: DateTime.now());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final shiftProvider =
    StateNotifierProvider<ShiftNotifier, ShiftState>((_) => ShiftNotifier());
final myPerformanceProvider =
    Provider<List<KpiMetric>>((_) => EmployeeMockData.myKpiMetrics);
final mySalesChartProvider =
    Provider<List<MonthlySales>>((_) => EmployeeMockData.myMonthlySales);
final myCustomersProvider =
    Provider<List<EmployeeCustomer>>((_) => EmployeeMockData.myCustomers);
final myTestDrivesProvider =
    Provider<List<TestDriveSchedule>>((_) => EmployeeMockData.myTestDrives);
final myRecentSalesProvider =
    Provider<List<Transaction>>((_) => EmployeeMockData.myRecentSales);

final pendingTasksProvider =
    StateNotifierProvider<PendingTasksNotifier, List<PendingTask>>(
        (_) => PendingTasksNotifier());

class PendingTasksNotifier extends StateNotifier<List<PendingTask>> {
  PendingTasksNotifier() : super(EmployeeMockData.pendingTasks);

  void toggleTask(String id) {
    state = [
      for (final t in state)
        if (t.id == id) t.copyWith(isCompleted: !t.isCompleted) else t
    ];
  }
}

final kpiMetricsProvider =
    Provider<List<KpiMetric>>((_) => MockData.kpiMetrics);
final inventoryStatusProvider =
    Provider<InventoryStatus>((_) => MockData.inventoryStatus);
final recentTransactionsProvider =
    Provider<List<Transaction>>((_) => MockData.recentTransactions);
final loanOverviewProvider =
    Provider<LoanOverview>((_) => MockData.loanOverview);
final upcomingTestDrivesProvider =
    Provider<List<TestDriveSchedule>>((_) => MockData.upcomingTestDrives);
final monthlySalesProvider =
    Provider<List<MonthlySales>>((_) => MockData.monthlySales);
final bottomNavIndexProvider = StateProvider<int>((_) => 0);

