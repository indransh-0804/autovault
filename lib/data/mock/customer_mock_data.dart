// data/mock/customer_mock_data.dart

import '../models/customer_model.dart';
import '../models/interaction_model.dart';

// ─── Mock Customers ───────────────────────────────────────────────────────────

final mockCustomers = <CustomerModel>[
  CustomerModel(
    id: 'cust_001',
    firstName: 'Arjun',
    lastName: 'Mehta',
    phone: '+919876543210',
    email: 'arjun.mehta@gmail.com',
    dateOfBirth: DateTime(1990, 3, 12),
    address: '14, Sunrise Apartments, Vesu, Surat - 395007',
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    leadStatus: LeadStatus.converted,
    notes: 'Bought Baleno in Nov 2024. Interested in upgrading to Creta next year.',
    purchaseIds: ['sale_001'],
    loanIds: ['loan_001'],
    testDriveIds: ['td_001'],
    createdAt: DateTime(2024, 9, 5),
    lastInteractionAt: DateTime(2024, 11, 18),
  ),
  CustomerModel(
    id: 'cust_002',
    firstName: 'Priya',
    lastName: 'Nair',
    phone: '+919845001122',
    email: 'priya.nair@outlook.com',
    dateOfBirth: DateTime(1995, 7, 22),
    address: '3B, Palm Grove Society, Adajan, Surat - 395009',
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    leadStatus: LeadStatus.hotLead,
    notes: 'Very interested in Tata Nexon EV. Has test driven once. Waiting for finance approval.',
    purchaseIds: [],
    loanIds: [],
    testDriveIds: ['td_002'],
    createdAt: DateTime(2024, 11, 20),
    lastInteractionAt: DateTime(2024, 12, 2),
  ),
  CustomerModel(
    id: 'cust_003',
    firstName: 'Vikram',
    lastName: 'Patel',
    phone: '+917698001234',
    email: 'vikrampatel@yahoo.com',
    dateOfBirth: DateTime(1985, 1, 8),
    address: '22, Shreenath Complex, Katargam, Surat - 395004',
    assignedEmployeeId: 'emp_002',
    assignedEmployeeName: 'Sneha Desai',
    leadStatus: LeadStatus.followUp,
    notes: 'Looking for a 7-seater, budget ₹20L. Showed interest in Innova Crysta.',
    purchaseIds: [],
    loanIds: [],
    testDriveIds: [],
    createdAt: DateTime(2024, 10, 14),
    lastInteractionAt: DateTime(2024, 11, 30),
  ),
  CustomerModel(
    id: 'cust_004',
    firstName: 'Neha',
    lastName: 'Joshi',
    phone: '+918866223344',
    email: 'neha.joshi@hotmail.com',
    dateOfBirth: DateTime(1998, 11, 3),
    address: '7, Tulsi Park, Varachha, Surat - 395006',
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    leadStatus: LeadStatus.converted,
    notes: 'Purchased Swift ZXi+. Very happy customer, referred 2 friends.',
    purchaseIds: ['sale_002'],
    loanIds: [],
    testDriveIds: ['td_003'],
    createdAt: DateTime(2024, 8, 10),
    lastInteractionAt: DateTime(2024, 12, 5),
  ),
  CustomerModel(
    id: 'cust_005',
    firstName: 'Rahul',
    lastName: 'Gupta',
    phone: '+919512345678',
    email: 'rahul.gupta@gmail.com',
    dateOfBirth: DateTime(1988, 5, 17),
    address: '101, Green Valley, Piplod, Surat - 395007',
    assignedEmployeeId: 'emp_002',
    assignedEmployeeName: 'Sneha Desai',
    leadStatus: LeadStatus.hotLead,
    notes: 'Wants Hyundai Creta diesel. Discussed finance options. Follow up Tuesday.',
    purchaseIds: [],
    loanIds: [],
    testDriveIds: ['td_004'],
    createdAt: DateTime(2024, 12, 1),
    lastInteractionAt: DateTime(2024, 12, 4),
  ),
  CustomerModel(
    id: 'cust_006',
    firstName: 'Anjali',
    lastName: 'Singh',
    phone: '+917755443322',
    email: 'anjali.singh@gmail.com',
    dateOfBirth: DateTime(1993, 9, 25),
    address: '5, Shivalik Residency, Pal, Surat - 395009',
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    leadStatus: LeadStatus.inactive,
    notes: 'Was interested in Honda City but went with a competitor. Keep for future.',
    purchaseIds: [],
    loanIds: [],
    testDriveIds: [],
    createdAt: DateTime(2024, 7, 20),
    lastInteractionAt: DateTime(2024, 9, 15),
  ),
  CustomerModel(
    id: 'cust_007',
    firstName: 'Karan',
    lastName: 'Shah',
    phone: '+919898765432',
    email: 'karan.shah@icloud.com',
    dateOfBirth: DateTime(1982, 4, 30),
    address: '18, Silver Oak Bungalow, Dindoli, Surat - 395004',
    assignedEmployeeId: 'emp_002',
    assignedEmployeeName: 'Sneha Desai',
    leadStatus: LeadStatus.converted,
    notes: 'Fleet purchase — bought 2 vehicles for business. Excellent relationship.',
    purchaseIds: ['sale_003', 'sale_004'],
    loanIds: ['loan_002'],
    testDriveIds: [],
    createdAt: DateTime(2024, 6, 12),
    lastInteractionAt: DateTime(2024, 11, 5),
  ),
  CustomerModel(
    id: 'cust_008',
    firstName: 'Deepika',
    lastName: 'Rao',
    phone: '+918877665544',
    email: 'deepika.rao@gmail.com',
    dateOfBirth: DateTime(2000, 2, 14),
    address: '9, Rajhans Society, Althan, Surat - 395017',
    assignedEmployeeId: 'emp_001',
    assignedEmployeeName: 'Rohan Sharma',
    leadStatus: LeadStatus.followUp,
    notes: 'First-time buyer. Budget ₹8–10L. Interested in Swift or Punch.',
    purchaseIds: [],
    loanIds: [],
    testDriveIds: [],
    createdAt: DateTime(2024, 11, 28),
    lastInteractionAt: DateTime(2024, 12, 3),
  ),
];

// ─── Mock Interactions ────────────────────────────────────────────────────────

final mockInteractions = <InteractionModel>[
  // Arjun Mehta (cust_001)
  InteractionModel(id: 'int_001', customerId: 'cust_001', type: InteractionType.visit,
      note: 'Walked in, enquired about Baleno and Swift options.', timestamp: DateTime(2024, 9, 6)),
  InteractionModel(id: 'int_002', customerId: 'cust_001', type: InteractionType.testDrive,
      note: 'Test drove Baleno Alpha CVT — very positive feedback.', timestamp: DateTime(2024, 10, 12)),
  InteractionModel(id: 'int_003', customerId: 'cust_001', type: InteractionType.call,
      note: 'Discussed finance options and confirmed loan eligibility.', timestamp: DateTime(2024, 11, 2)),
  InteractionModel(id: 'int_004', customerId: 'cust_001', type: InteractionType.purchase,
      note: 'Purchased Maruti Baleno Alpha. Loan processed via SBI.', timestamp: DateTime(2024, 11, 18)),

  // Priya Nair (cust_002)
  InteractionModel(id: 'int_005', customerId: 'cust_002', type: InteractionType.visit,
      note: 'Walk-in. Specifically asked for EVs — Nexon EV Max shown.', timestamp: DateTime(2024, 11, 20)),
  InteractionModel(id: 'int_006', customerId: 'cust_002', type: InteractionType.testDrive,
      note: 'Test drove Nexon EV Max. Loved the performance. Needs finance clearance.', timestamp: DateTime(2024, 11, 25)),
  InteractionModel(id: 'int_007', customerId: 'cust_002', type: InteractionType.call,
      note: 'Called to follow up on finance status. Still in process.', timestamp: DateTime(2024, 12, 2)),

  // Vikram Patel (cust_003)
  InteractionModel(id: 'int_008', customerId: 'cust_003', type: InteractionType.call,
      note: 'Cold call. Interested in 7-seater options.', timestamp: DateTime(2024, 10, 14)),
  InteractionModel(id: 'int_009', customerId: 'cust_003', type: InteractionType.visit,
      note: 'Came with family, walked through Innova Crysta and Tata Safari.', timestamp: DateTime(2024, 11, 10)),
  InteractionModel(id: 'int_010', customerId: 'cust_003', type: InteractionType.call,
      note: 'Follow-up call. Still deciding between Crysta and Safari.', timestamp: DateTime(2024, 11, 30)),

  // Neha Joshi (cust_004)
  InteractionModel(id: 'int_011', customerId: 'cust_004', type: InteractionType.visit,
      note: 'Enquired about hatchbacks under ₹10L.', timestamp: DateTime(2024, 8, 10)),
  InteractionModel(id: 'int_012', customerId: 'cust_004', type: InteractionType.testDrive,
      note: 'Test drove Swift ZXi+ — immediate interest.', timestamp: DateTime(2024, 11, 28)),
  InteractionModel(id: 'int_013', customerId: 'cust_004', type: InteractionType.purchase,
      note: 'Purchased Swift ZXi+ Lucent Orange. Full cash payment.', timestamp: DateTime(2024, 12, 5)),

  // Rahul Gupta (cust_005)
  InteractionModel(id: 'int_014', customerId: 'cust_005', type: InteractionType.visit,
      note: 'Walk-in, saw the Creta display and was immediately interested.', timestamp: DateTime(2024, 12, 1)),
  InteractionModel(id: 'int_015', customerId: 'cust_005', type: InteractionType.testDrive,
      note: 'Test drove Creta SX(O) diesel. Very impressed with torque.', timestamp: DateTime(2024, 12, 3)),
  InteractionModel(id: 'int_016', customerId: 'cust_005', type: InteractionType.call,
      note: 'Discussed EMI options. Needs ₹2L exchange value for old i10.', timestamp: DateTime(2024, 12, 4)),

  // Karan Shah (cust_007)
  InteractionModel(id: 'int_017', customerId: 'cust_007', type: InteractionType.visit,
      note: 'Corporate inquiry for fleet vehicles — needed 2 sedans.', timestamp: DateTime(2024, 6, 12)),
  InteractionModel(id: 'int_018', customerId: 'cust_007', type: InteractionType.call,
      note: 'Negotiated corporate pricing. Agreed on bulk discount.', timestamp: DateTime(2024, 9, 20)),
  InteractionModel(id: 'int_019', customerId: 'cust_007', type: InteractionType.purchase,
      note: 'Purchased Honda City ZX + Tata Punch. Fleet deal closed.', timestamp: DateTime(2024, 11, 5)),

  // Deepika Rao (cust_008)
  InteractionModel(id: 'int_020', customerId: 'cust_008', type: InteractionType.visit,
      note: 'First visit — first-time buyer, explored Swift and Punch.', timestamp: DateTime(2024, 11, 28)),
  InteractionModel(id: 'int_021', customerId: 'cust_008', type: InteractionType.call,
      note: 'Called for pricing breakdown and EMI estimate.', timestamp: DateTime(2024, 12, 3)),
];

// ─── Mock Loan Summaries (keyed by loanId) ───────────────────────────────────

class MockLoanSummary {
  final String loanId;
  final String customerId;
  final double totalAmount;
  final double amountPaid;
  final DateTime nextDueDate;
  final String bankName;

  const MockLoanSummary({
    required this.loanId,
    required this.customerId,
    required this.totalAmount,
    required this.amountPaid,
    required this.nextDueDate,
    required this.bankName,
  });

  double get amountRemaining => totalAmount - amountPaid;
  double get repaymentProgress => amountPaid / totalAmount;
}

final mockLoanSummaries = <MockLoanSummary>[
  MockLoanSummary(
    loanId: 'loan_001',
    customerId: 'cust_001',
    totalAmount: 700000,
    amountPaid: 175000,
    nextDueDate: DateTime(2025, 1, 5),
    bankName: 'SBI Auto Loan',
  ),
  MockLoanSummary(
    loanId: 'loan_002',
    customerId: 'cust_007',
    totalAmount: 1200000,
    amountPaid: 480000,
    nextDueDate: DateTime(2025, 1, 10),
    bankName: 'HDFC Car Finance',
  ),
];

// ─── Mock Purchases ───────────────────────────────────────────────────────────

class MockPurchaseEntry {
  final String id;
  final String customerId;
  final String carMakeModel;
  final int year;
  final double amount;
  final DateTime date;
  final String paymentType; // 'Cash' | 'Loan'
  final String? loanId;

  const MockPurchaseEntry({
    required this.id,
    required this.customerId,
    required this.carMakeModel,
    required this.year,
    required this.amount,
    required this.date,
    required this.paymentType,
    this.loanId,
  });
}

final mockPurchases = <MockPurchaseEntry>[
  MockPurchaseEntry(
    id: 'sale_001', customerId: 'cust_001',
    carMakeModel: 'Maruti Suzuki Baleno Alpha',
    year: 2024, amount: 895000,
    date: DateTime(2024, 11, 18),
    paymentType: 'Loan', loanId: 'loan_001',
  ),
  MockPurchaseEntry(
    id: 'sale_002', customerId: 'cust_004',
    carMakeModel: 'Maruti Suzuki Swift ZXi+',
    year: 2024, amount: 849000,
    date: DateTime(2024, 12, 5),
    paymentType: 'Cash',
  ),
  MockPurchaseEntry(
    id: 'sale_003', customerId: 'cust_007',
    carMakeModel: 'Honda City ZX CVT',
    year: 2022, amount: 1195000,
    date: DateTime(2024, 11, 5),
    paymentType: 'Loan', loanId: 'loan_002',
  ),
  MockPurchaseEntry(
    id: 'sale_004', customerId: 'cust_007',
    carMakeModel: 'Tata Punch Creative AMT',
    year: 2024, amount: 1025000,
    date: DateTime(2024, 11, 5),
    paymentType: 'Cash',
  ),
];
