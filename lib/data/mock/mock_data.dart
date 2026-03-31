import 'package:autovault/data/models/dashboard_models.dart';

class MockData {
  static const String ownerName = 'Indransh Sharma';
  static const String ownerInitials = 'IS';
  static const int notificationCount = 10;

  static const List<KpiMetric> kpiMetrics = [
    KpiMetric(
        title: 'Total Revenue',
        value: '₹4.5L',
        changePercent: '+12.3%',
        isPositive: true,
        iconName: 'revenue'),
    KpiMetric(
        title: 'Cars Sold',
        value: '23',
        changePercent: '+8.5%',
        isPositive: true,
        iconName: 'cars_sold'),
    KpiMetric(
        title: 'Active Loans',
        value: '17',
        changePercent: '-3.2%',
        isPositive: false,
        iconName: 'loans'),
    KpiMetric(
        title: 'Pending Test Drives',
        value: '9',
        changePercent: '+15.0%',
        isPositive: true,
        iconName: 'test_drives'),
  ];

  static const InventoryStatus inventoryStatus =
      InventoryStatus(available: 8, reserved: 48, sold: 0);

  static final List<Transaction> recentTransactions = [
    Transaction(
        customerName: 'Amit Sharma',
        carModel: 'Hyundai Creta 2026',
        amount: '₹14,50,000',
        status: TransactionStatus.paid,
        date: DateTime(2026, 2, 28)),
    Transaction(
        customerName: 'Priya Mehta',
        carModel: 'Tata Nexon EV',
        amount: '₹16,20,000',
        status: TransactionStatus.loan,
        date: DateTime(2026, 2, 27)),
    Transaction(
        customerName: 'Vikram Singh',
        carModel: 'Maruti Grand Vitara',
        amount: '₹12,80,000',
        status: TransactionStatus.paid,
        date: DateTime(2026, 2, 26)),
    Transaction(
        customerName: 'Neha Gupta',
        carModel: 'Kia Seltos',
        amount: '₹15,30,000',
        status: TransactionStatus.pending,
        date: DateTime(2026, 2, 25)),
    Transaction(
        customerName: 'Rohan Patel',
        carModel: 'MG Hector Plus',
        amount: '₹18,90,000',
        status: TransactionStatus.loan,
        date: DateTime(2026, 2, 24)),
  ];

  static const LoanOverview loanOverview = LoanOverview(
      totalActiveLoans: 17, amountCollected: '₹12.8L', overdueLoans: 3);

  static const List<TestDriveSchedule> upcomingTestDrives = [
    TestDriveSchedule(
        customerName: 'Arjun Reddy',
        carModel: 'Tata Harrier',
        time: '10:30 AM',
        assignedEmployee: 'Suresh K.'),
    TestDriveSchedule(
        customerName: 'Sana Khan',
        carModel: 'Hyundai Tucson',
        time: '12:00 PM',
        assignedEmployee: 'Manoj P.'),
    TestDriveSchedule(
        customerName: 'Deepak Joshi',
        carModel: 'Kia Sonet',
        time: '03:15 PM',
        assignedEmployee: 'Ravi M.'),
    TestDriveSchedule(
        customerName: 'Deepak Joshi',
        carModel: 'Kia Sonet',
        time: '03:15 PM',
        assignedEmployee: 'Ravi M.'),
  ];

  static const List<MonthlySales> monthlySales = [
    MonthlySales(month: 'Jan', value: 18),
    MonthlySales(month: 'Feb', value: 23),
    MonthlySales(month: 'Mar', value: 15),
    MonthlySales(month: 'Apr', value: 20),
    MonthlySales(month: 'May', value: 28),
    MonthlySales(month: 'Jun', value: 25),
    MonthlySales(month: 'Jul', value: 30),
    MonthlySales(month: 'Aug', value: 22),
    MonthlySales(month: 'Sep', value: 27),
    MonthlySales(month: 'Oct', value: 32),
    MonthlySales(month: 'Nov', value: 29),
    MonthlySales(month: 'Dec', value: 35),
  ];
}
