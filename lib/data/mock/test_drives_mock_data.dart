// data/mock/test_drives_mock_data.dart

import '../models/test_drive_activity_model.dart';
import '../models/test_drive_model.dart';

// Anchor to today so calendar dots always appear relative to now
final _today = DateTime.now();
DateTime _d(int daysFromToday, int hour, int minute) => DateTime(
      _today.year,
      _today.month,
      _today.day + daysFromToday,
      hour,
      minute,
    );

final mockTestDrives = <TestDriveModel>[
  // ── Today — 2 drives (multi-dot test) ────────────────────────────────────

  TestDriveModel(
    id: 'td_001',
    customerId: 'cust_002',
    customerName: 'Priya Nair',
    customerPhone: '+919845001122',
    carId: 'car_003',
    carMake: 'Tata',
    carModel: 'Nexon EV Max',
    carYear: 2023,
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    scheduledAt: _d(0, 10, 30),
    durationMinutes: 30,
    status: TestDriveStatus.inProgress,
    location: 'City loop via VIP Road',
    notes: 'Customer specifically wants to test regenerative braking.',
    activityLog: [
      TestDriveActivityModel(
        id: 'act_001a',
        timestamp: _d(-2, 14, 0),
        description: 'Test drive booked by Rohan Sharma.',
        type: TestDriveActivityType.booked,
      ),
      TestDriveActivityModel(
        id: 'act_001b',
        timestamp: _d(-1, 9, 0),
        description: 'Status changed to Confirmed.',
        type: TestDriveActivityType.confirmed,
      ),
      TestDriveActivityModel(
        id: 'act_001c',
        timestamp: _d(0, 10, 28),
        description: 'Test drive started — customer arrived on time.',
        type: TestDriveActivityType.statusChanged,
      ),
    ],
    createdAt: _d(-2, 14, 0),
  ),

  TestDriveModel(
    id: 'td_002',
    customerId: 'cust_005',
    customerName: 'Rahul Gupta',
    customerPhone: '+919512345678',
    carId: 'car_002',
    carMake: 'Hyundai',
    carModel: 'Creta SX(O)',
    carYear: 2024,
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    scheduledAt: _d(0, 14, 0),
    durationMinutes: 45,
    status: TestDriveStatus.confirmed,
    location: 'Ring road route — 20 km stretch',
    notes: 'Compare diesel torque vs petrol. Customer is technical.',
    activityLog: [
      TestDriveActivityModel(
        id: 'act_002a',
        timestamp: _d(-1, 16, 30),
        description: 'Test drive booked by Rohan Sharma.',
        type: TestDriveActivityType.booked,
      ),
      TestDriveActivityModel(
        id: 'act_002b',
        timestamp: _d(-1, 18, 0),
        description: 'Confirmed via phone call.',
        type: TestDriveActivityType.confirmed,
      ),
    ],
    createdAt: _d(-1, 16, 30),
  ),

  // ── Tomorrow ──────────────────────────────────────────────────────────────

  TestDriveModel(
    id: 'td_003',
    customerId: 'cust_008',
    customerName: 'Deepika Rao',
    customerPhone: '+918877665544',
    carId: 'car_001',
    carMake: 'Maruti Suzuki',
    carModel: 'Baleno Alpha',
    carYear: 2024,
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    scheduledAt: _d(1, 11, 0),
    durationMinutes: 30,
    status: TestDriveStatus.confirmed,
    location: 'Showroom to Adajan and back',
    notes: 'First-time buyer. Be patient and explain all features.',
    activityLog: [
      TestDriveActivityModel(
        id: 'act_003a',
        timestamp: _d(0, 9, 0),
        description: 'Test drive scheduled for tomorrow.',
        type: TestDriveActivityType.booked,
      ),
    ],
    createdAt: _d(0, 9, 0),
  ),

  // ── Day after tomorrow — conflict scenario (same car as td_003 + 1 hour) ──

  TestDriveModel(
    id: 'td_004',
    customerId: 'cust_003',
    customerName: 'Vikram Patel',
    customerPhone: '+917698001234',
    carId: 'car_005',
    carMake: 'Toyota',
    carModel: 'Innova Crysta GX',
    carYear: 2023,
    assignedEmployeeId: 'emp_002',
    assignedEmployeeName: 'Sneha Desai',
    scheduledAt: _d(2, 10, 0),
    durationMinutes: 60,
    status: TestDriveStatus.pending,
    location: 'Highway stretch, Magdalla to Dumas',
    notes: 'Bring family — needs 7-seater feel check.',
    activityLog: [
      TestDriveActivityModel(
        id: 'act_004a',
        timestamp: _d(0, 11, 0),
        description: 'Booked via customer request during showroom visit.',
        type: TestDriveActivityType.booked,
      ),
    ],
    createdAt: _d(0, 11, 0),
  ),

  // ── 3 days from now ───────────────────────────────────────────────────────

  TestDriveModel(
    id: 'td_005',
    customerId: 'cust_001',
    customerName: 'Arjun Mehta',
    customerPhone: '+919876543210',
    carId: 'car_006',
    carMake: 'Maruti Suzuki',
    carModel: 'Swift ZXi+',
    carYear: 2024,
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    scheduledAt: _d(3, 16, 30),
    durationMinutes: 30,
    status: TestDriveStatus.pending,
    location: 'Showroom vicinity',
    notes: 'Existing customer — wants to test new Swift before upgrade decision.',
    activityLog: [
      TestDriveActivityModel(
        id: 'act_005a',
        timestamp: _d(0, 15, 0),
        description: 'Booked at customer request.',
        type: TestDriveActivityType.booked,
      ),
    ],
    createdAt: _d(0, 15, 0),
  ),

  // ── 5 days from now ───────────────────────────────────────────────────────

  TestDriveModel(
    id: 'td_006',
    customerId: 'cust_007',
    customerName: 'Karan Shah',
    customerPhone: '+919898765432',
    carId: 'car_003',
    carMake: 'Tata',
    carModel: 'Nexon EV Max',
    carYear: 2023,
    assignedEmployeeId: 'emp_002',
    assignedEmployeeName: 'Sneha Desai',
    scheduledAt: _d(5, 9, 0),
    durationMinutes: 45,
    status: TestDriveStatus.confirmed,
    location: 'Industrial area loop — good for EV range test',
    notes: 'Corporate customer — second drive before fleet EV decision.',
    activityLog: [
      TestDriveActivityModel(
        id: 'act_006a',
        timestamp: _d(1, 10, 0),
        description: 'Scheduled after fleet inquiry call.',
        type: TestDriveActivityType.booked,
      ),
      TestDriveActivityModel(
        id: 'act_006b',
        timestamp: _d(2, 14, 0),
        description: 'Confirmed. Customer will bring CFO.',
        type: TestDriveActivityType.confirmed,
      ),
    ],
    createdAt: _d(1, 10, 0),
  ),

  // ── 8 days from now ───────────────────────────────────────────────────────

  TestDriveModel(
    id: 'td_007',
    customerId: 'cust_006',
    customerName: 'Anjali Singh',
    customerPhone: '+917755443322',
    carId: 'car_001',
    carMake: 'Maruti Suzuki',
    carModel: 'Baleno Alpha',
    carYear: 2024,
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    scheduledAt: _d(8, 11, 30),
    durationMinutes: 30,
    status: TestDriveStatus.pending,
    location: 'City drive — customer preference',
    notes: 'Reactivating inactive lead. Be enthusiastic.',
    activityLog: [
      TestDriveActivityModel(
        id: 'act_007a',
        timestamp: _d(3, 16, 0),
        description: 'Booked to re-engage inactive lead.',
        type: TestDriveActivityType.booked,
      ),
    ],
    createdAt: _d(3, 16, 0),
  ),

  // ── 12 days from now ──────────────────────────────────────────────────────

  TestDriveModel(
    id: 'td_008',
    customerId: 'cust_004',
    customerName: 'Neha Joshi',
    customerPhone: '+918866223344',
    carId: 'car_006',
    carMake: 'Maruti Suzuki',
    carModel: 'Swift ZXi+',
    carYear: 2024,
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    scheduledAt: _d(12, 10, 0),
    durationMinutes: 30,
    status: TestDriveStatus.confirmed,
    location: 'Showroom standard route',
    notes: 'Referred by existing customer. Already sold on Swift.',
    activityLog: [
      TestDriveActivityModel(
        id: 'act_008a',
        timestamp: _d(5, 13, 0),
        description: 'Booked via referral.',
        type: TestDriveActivityType.booked,
      ),
      TestDriveActivityModel(
        id: 'act_008b',
        timestamp: _d(6, 9, 0),
        description: 'Confirmed and reminder sent.',
        type: TestDriveActivityType.confirmed,
      ),
    ],
    createdAt: _d(5, 13, 0),
  ),

  // ── Past — completed, converted to sale ───────────────────────────────────

  TestDriveModel(
    id: 'td_009',
    customerId: 'cust_001',
    customerName: 'Arjun Mehta',
    customerPhone: '+919876543210',
    carId: 'car_001',
    carMake: 'Maruti Suzuki',
    carModel: 'Baleno Alpha',
    carYear: 2024,
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    scheduledAt: _d(-10, 11, 0),
    durationMinutes: 30,
    status: TestDriveStatus.completed,
    location: 'City loop via VIP Road',
    notes: 'Excellent drive. Customer very impressed with CVT smoothness.',
    activityLog: [
      TestDriveActivityModel(
        id: 'act_009a',
        timestamp: _d(-12, 10, 0),
        description: 'Test drive booked.',
        type: TestDriveActivityType.booked,
      ),
      TestDriveActivityModel(
        id: 'act_009b',
        timestamp: _d(-11, 9, 0),
        description: 'Confirmed.',
        type: TestDriveActivityType.confirmed,
      ),
      TestDriveActivityModel(
        id: 'act_009c',
        timestamp: _d(-10, 11, 35),
        description: 'Test drive completed successfully.',
        type: TestDriveActivityType.statusChanged,
      ),
      TestDriveActivityModel(
        id: 'act_009d',
        timestamp: _d(-10, 14, 0),
        description: 'Converted to sale — sale_001 created.',
        type: TestDriveActivityType.converted,
      ),
    ],
    createdAt: _d(-12, 10, 0),
    convertedToPurchaseId: 'sale_001',
  ),

  // ── Past — cancelled ──────────────────────────────────────────────────────

  TestDriveModel(
    id: 'td_010',
    customerId: 'cust_003',
    customerName: 'Vikram Patel',
    customerPhone: '+917698001234',
    carId: 'car_005',
    carMake: 'Toyota',
    carModel: 'Innova Crysta GX',
    carYear: 2023,
    assignedEmployeeId: 'emp_002',
    assignedEmployeeName: 'Sneha Desai',
    scheduledAt: _d(-5, 15, 0),
    durationMinutes: 60,
    status: TestDriveStatus.cancelled,
    location: 'Highway route',
    notes: 'Customer cancelled — family emergency.',
    activityLog: [
      TestDriveActivityModel(
        id: 'act_010a',
        timestamp: _d(-8, 11, 0),
        description: 'Test drive booked.',
        type: TestDriveActivityType.booked,
      ),
      TestDriveActivityModel(
        id: 'act_010b',
        timestamp: _d(-6, 8, 0),
        description: 'Customer called to cancel — family emergency.',
        type: TestDriveActivityType.cancelled,
      ),
    ],
    createdAt: _d(-8, 11, 0),
  ),
];
