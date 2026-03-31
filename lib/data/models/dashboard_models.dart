class KpiMetric {
  final String title;
  final String value;
  final String changePercent;
  final bool isPositive;
  final String iconName;
  const KpiMetric({
    required this.title,
    required this.value,
    required this.changePercent,
    required this.isPositive,
    required this.iconName,
  });
}

class Transaction {
  final String customerName;
  final String carModel;
  final String amount;
  final TransactionStatus status;
  final DateTime date;
  const Transaction({
    required this.customerName,
    required this.carModel,
    required this.amount,
    required this.status,
    required this.date,
  });
}

enum TransactionStatus { paid, loan, pending }

class InventoryStatus {
  final int available;
  final int reserved;
  final int sold;
  const InventoryStatus({
    required this.available,
    required this.reserved,
    required this.sold,
  });
  int get total => available + reserved + sold;
}

class TestDriveSchedule {
  final String customerName;
  final String carModel;
  final String time;
  final String assignedEmployee;
  const TestDriveSchedule({
    required this.customerName,
    required this.carModel,
    required this.time,
    required this.assignedEmployee,
  });
}

class LoanOverview {
  final int totalActiveLoans;
  final String amountCollected;
  final int overdueLoans;
  const LoanOverview({
    required this.totalActiveLoans,
    required this.amountCollected,
    required this.overdueLoans,
  });
}

class MonthlySales {
  final String month;
  final double value;
  const MonthlySales({required this.month, required this.value});
}

class EmployeeCustomer {
  final String name;
  final String lastInteraction;
  final CustomerLeadStatus leadStatus;
  const EmployeeCustomer({
    required this.name,
    required this.lastInteraction,
    required this.leadStatus,
  });
}

enum CustomerLeadStatus { hotLead, followUp, converted }