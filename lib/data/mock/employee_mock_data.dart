import 'package:autovault/data/models/dashboard_models.dart';
import 'package:autovault/data/models/task_model.dart';

class EmployeeMockData {
  static const String employeeName = 'James Okafor';
  static const String employeeTitle = 'Senior Sales Executive';
  static const String employeeInitials = 'JO';
  static const int notificationCount = 3;
  static const int monthlyTarget = 15;
  static const int currentSalesCount = 11;

  static const List<KpiMetric> myKpiMetrics = [
    KpiMetric(title: 'My Sales', value: '11', changePercent: '+22.2%', isPositive: true, iconName: 'cars_sold'),
    KpiMetric(title: 'Revenue Generated', value: '₹18.2L', changePercent: '+15.7%', isPositive: true, iconName: 'revenue'),
    KpiMetric(title: 'Active Customers', value: '24', changePercent: '+8.0%', isPositive: true, iconName: 'test_drives'),
    KpiMetric(title: 'Commission', value: '₹1.82L', changePercent: '+15.7%', isPositive: true, iconName: 'loans'),
  ];

  static const List<MonthlySales> myMonthlySales = [
    MonthlySales(month: 'W1', value: 3), MonthlySales(month: 'W2', value: 2),
    MonthlySales(month: 'W3', value: 4), MonthlySales(month: 'W4', value: 2),
  ];

  static const List<EmployeeCustomer> myCustomers = [
    EmployeeCustomer(name: 'Sneha Iyer', lastInteraction: '28 Feb 2026', leadStatus: CustomerLeadStatus.hotLead),
    EmployeeCustomer(name: 'Ravi Shankar', lastInteraction: '27 Feb 2026', leadStatus: CustomerLeadStatus.followUp),
    EmployeeCustomer(name: 'Meera Joshi', lastInteraction: '25 Feb 2026', leadStatus: CustomerLeadStatus.converted),
    EmployeeCustomer(name: 'Karthik Nair', lastInteraction: '24 Feb 2026', leadStatus: CustomerLeadStatus.hotLead),
    EmployeeCustomer(name: 'Aisha Begum', lastInteraction: '23 Feb 2026', leadStatus: CustomerLeadStatus.followUp),
  ];

  static const List<TestDriveSchedule> myTestDrives = [
    TestDriveSchedule(customerName: 'Sneha Iyer', carModel: 'Hyundai Creta 2026', time: '11:00 AM — Today', assignedEmployee: 'James O.'),
    TestDriveSchedule(customerName: 'Karthik Nair', carModel: 'Tata Harrier', time: '02:30 PM — Today', assignedEmployee: 'James O.'),
    TestDriveSchedule(customerName: 'Aisha Begum', carModel: 'Kia Seltos', time: '10:00 AM — Tomorrow', assignedEmployee: 'James O.'),
  ];

  static final List<Transaction> myRecentSales = [
    Transaction(customerName: 'Meera Joshi', carModel: 'Maruti Grand Vitara', amount: '₹12,80,000', status: TransactionStatus.paid, date: DateTime(2026, 2, 28)),
    Transaction(customerName: 'Rahul Desai', carModel: 'Hyundai Verna', amount: '₹11,50,000', status: TransactionStatus.loan, date: DateTime(2026, 2, 26)),
    Transaction(customerName: 'Pooja Reddy', carModel: 'Tata Nexon', amount: '₹10,20,000', status: TransactionStatus.paid, date: DateTime(2026, 2, 24)),
    Transaction(customerName: 'Sanjay Kulkarni', carModel: 'Kia Sonet', amount: '₹9,80,000', status: TransactionStatus.loan, date: DateTime(2026, 2, 22)),
  ];

  static const List<PendingTask> pendingTasks = [
    PendingTask(id: '1', title: 'Follow up with Sneha Iyer on Creta pricing', dueTime: '11:30 AM'),
    PendingTask(id: '2', title: 'Submit loan application for Rahul Desai', dueTime: '01:00 PM'),
    PendingTask(id: '3', title: 'Confirm test drive with Karthik Nair', dueTime: '02:00 PM'),
    PendingTask(id: '4', title: 'Prepare delivery checklist — Pooja Reddy', dueTime: '04:00 PM'),
    PendingTask(id: '5', title: 'Call Aisha Begum to confirm tomorrow\'s visit', dueTime: '05:30 PM'),
  ];
}