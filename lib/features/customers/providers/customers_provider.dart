// features/customers/providers/customers_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/customer_model.dart';
import '../../../data/mock/customer_mock_data.dart';

part 'customers_provider.g.dart';

// ─── Main Notifier ────────────────────────────────────────────────────────────

@riverpod
class CustomersNotifier extends _$CustomersNotifier {
  @override
  List<CustomerModel> build() => List.from(mockCustomers);

  void addCustomer(CustomerModel customer) {
    state = [customer, ...state];
  }

  void updateCustomer(CustomerModel updated) {
    state = [
      for (final c in state)
        if (c.id == updated.id) updated else c,
    ];
  }

  void deleteCustomer(String id) {
    state = state.where((c) => c.id != id).toList();
  }

  void reassignEmployee(String customerId, String employeeId, String employeeName) {
    state = [
      for (final c in state)
        if (c.id == customerId)
          c.copyWith(
            assignedEmployeeId: employeeId,
            assignedEmployeeName: employeeName,
          )
        else
          c,
    ];
  }

  void updateLeadStatus(String customerId, LeadStatus status) {
    state = [
      for (final c in state)
        if (c.id == customerId)
          c.copyWith(
            leadStatus: status,
            lastInteractionAt: DateTime.now(),
          )
        else
          c,
    ];
  }

  void addPurchaseId(String customerId, String purchaseId) {
    state = [
      for (final c in state)
        if (c.id == customerId)
          c.copyWith(purchaseIds: [...c.purchaseIds, purchaseId])
        else
          c,
    ];
  }

  void addLoanId(String customerId, String loanId) {
    state = [
      for (final c in state)
        if (c.id == customerId)
          c.copyWith(loanIds: [...c.loanIds, loanId])
        else
          c,
    ];
  }
}

// ─── Lookup by ID (used by Purchase Form, Loan Screen) ───────────────────────

@riverpod
CustomerModel? customerById(CustomerByIdRef ref, String id) {
  return ref
      .watch(customersNotifierProvider)
      .where((c) => c.id == id)
      .firstOrNull;
}

// ─── Filtered / searched ──────────────────────────────────────────────────────

@riverpod
List<CustomerModel> filteredCustomers(
  FilteredCustomersRef ref, {
  String query = '',
  String statusFilter = 'All',
  String sortBy = 'Recent',
  String? employeeId, // if non-null, restrict to this employee's customers
}) {
  var customers = ref.watch(customersNotifierProvider);

  // Employee scope
  if (employeeId != null && employeeId.isNotEmpty) {
    customers = customers
        .where((c) => c.assignedEmployeeId == employeeId)
        .toList();
  }

  // Status filter
  if (statusFilter != 'All') {
    final status = LeadStatus.values.firstWhere(
      (s) => s.label == statusFilter,
      orElse: () => LeadStatus.hotLead,
    );
    customers = customers.where((c) => c.leadStatus == status).toList();
  }

  // Text search
  if (query.isNotEmpty) {
    final q = query.toLowerCase();
    customers = customers
        .where((c) =>
            c.fullName.toLowerCase().contains(q) ||
            c.phone.contains(q) ||
            c.email.toLowerCase().contains(q))
        .toList();
  }

  // Sort
  switch (sortBy) {
    case 'Name A–Z':
      customers.sort((a, b) => a.fullName.compareTo(b.fullName));
    case 'Most Purchases':
      customers.sort(
          (a, b) => b.purchaseIds.length.compareTo(a.purchaseIds.length));
    default: // 'Recent'
      customers.sort(
          (a, b) => b.lastInteractionAt.compareTo(a.lastInteractionAt));
  }

  return customers;
}

// ─── Convenience selectors (used by Purchase Form & Loan Screen) ──────────────

@riverpod
List<CustomerModel> customersByStatus(
    CustomersByStatusRef ref, LeadStatus status) {
  return ref
      .watch(customersNotifierProvider)
      .where((c) => c.leadStatus == status)
      .toList();
}

@riverpod
List<CustomerModel> customersByEmployee(
    CustomersByEmployeeRef ref, String employeeId) {
  return ref
      .watch(customersNotifierProvider)
      .where((c) => c.assignedEmployeeId == employeeId)
      .toList();
}

/// Returns all customers — useful for purchase/loan customer picker dropdowns.
@riverpod
List<CustomerModel> allCustomers(AllCustomersRef ref) {
  return ref.watch(customersNotifierProvider);
}
