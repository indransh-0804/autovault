import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/purchase_model.dart';

part 'purchases_provider.g.dart';

@riverpod
class PurchasesNotifier extends _$PurchasesNotifier {
  @override
  List<PurchaseModel> build() => [];
  Future<PurchaseModel> createPurchase(PurchaseModel purchase) async {
    // Simulate async work (Firestore write in production)
    await Future.delayed(const Duration(milliseconds: 600));

    state = [purchase, ...state];

    // ── Side effects ───────────────────────────────────────────────────────
    // Uncomment when wiring to real providers:
    //
    // 1. Mark car as Sold
    // ref.read(carsNotifierProvider.notifier)
    //     .updateStatus(purchase.carDetails.carId, CarStatus.sold);
    //
    // 2. Add purchaseId to customer record
    // ref.read(customersNotifierProvider.notifier)
    //     .addPurchaseId(purchase.customerId, purchase.id);
    //
    // 3. Create loan stub if applicable
    // if (purchase.loanId != null) {
    //   ref.read(loansNotifierProvider.notifier).createLoan(stubLoan);
    // }

    return purchase;
  }

  Future<void> updatePurchase(PurchaseModel updated) async {
    await Future.delayed(const Duration(milliseconds: 400));
    state = [
      for (final p in state)
        if (p.id == updated.id) updated else p,
    ];
  }

  Future<void> voidPurchase(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(status: PurchaseStatus.voided) else p,
    ];

    // Side effect: if voiding, set car back to available
    // ref.read(carsNotifierProvider.notifier)
    //     .updateStatus(purchase.carDetails.carId, CarStatus.available);
  }

  // ── Computed selectors ─────────────────────────────────────────────────────

  List<PurchaseModel> purchasesByCustomer(String customerId) =>
      state.where((p) => p.customerId == customerId).toList();

  List<PurchaseModel> purchasesByEmployee(String employeeId) =>
      state.where((p) => p.employeeId == employeeId).toList();

  List<PurchaseModel> recentPurchases({int limit = 10}) =>
      (state.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt)))
          .take(limit)
          .toList();
}

// ─── Derived providers ────────────────────────────────────────────────────────

@riverpod
List<PurchaseModel> purchasesByCustomer(
    PurchasesByCustomerRef ref, String customerId) {
  return ref
      .watch(purchasesNotifierProvider)
      .where((p) => p.customerId == customerId)
      .toList();
}

@riverpod
List<PurchaseModel> purchasesByEmployee(
    PurchasesByEmployeeRef ref, String employeeId) {
  return ref
      .watch(purchasesNotifierProvider)
      .where((p) => p.employeeId == employeeId)
      .toList();
}

@riverpod
PurchaseModel? purchaseById(PurchaseByIdRef ref, String id) {
  return ref
      .watch(purchasesNotifierProvider)
      .where((p) => p.id == id)
      .firstOrNull;
}

@riverpod
List<PurchaseModel> recentPurchases(RecentPurchasesRef ref, {int limit = 10}) {
  final all = ref.watch(purchasesNotifierProvider).toList()
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return all.take(limit).toList();
}
