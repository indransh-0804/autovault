// features/inventory/providers/parts_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/part_model.dart';
import '../../../data/mock/inventory_mock_data.dart';

part 'parts_provider.g.dart';

// ─── Notifier ─────────────────────────────────────────────────────────────────

@riverpod
class PartsNotifier extends _$PartsNotifier {
  @override
  List<PartModel> build() => List.from(mockParts);

  // ── CRUD ──────────────────────────────────────────────────────────────────

  void addPart(PartModel part) {
    state = [part, ...state];
  }

  void updatePart(PartModel updated) {
    state = [
      for (final p in state)
        if (p.id == updated.id) updated else p,
    ];
  }

  void deletePart(String id) {
    state = state.where((p) => p.id != id).toList();
  }
}

// ─── Filtered provider ────────────────────────────────────────────────────────

@riverpod
List<PartModel> filteredParts(
  FilteredPartsRef ref, {
  String query = '',
  String categoryFilter = 'All',
}) {
  final parts = ref.watch(partsNotifierProvider);

  return parts.where((part) {
    final q = query.toLowerCase();
    final matchesQuery = q.isEmpty ||
        part.name.toLowerCase().contains(q) ||
        part.partNumber.toLowerCase().contains(q) ||
        part.supplierName.toLowerCase().contains(q);

    final matchesCategory = categoryFilter == 'All' ||
        part.category.label == categoryFilter;

    return matchesQuery && matchesCategory;
  }).toList();
}

// ─── Low stock provider ───────────────────────────────────────────────────────

@riverpod
List<PartModel> lowStockParts(LowStockPartsRef ref) {
  final parts = ref.watch(partsNotifierProvider);
  return parts
      .where((p) => p.quantity <= p.reorderLevel)
      .toList();
}
