import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/car_model.dart';
import '../../../data/mock/inventory_mock_data.dart';
part 'cars_provider.g.dart';

// ─── Notifier ─────────────────────────────────────────────────────────────────

@riverpod
class CarsNotifier extends _$CarsNotifier {
  @override
  List<CarModel> build() => List.from(mockCars);

  // ── CRUD ──────────────────────────────────────────────────────────────────

  void addCar(CarModel car) {
    state = [car, ...state];
  }

  void updateCar(CarModel updated) {
    state = [
      for (final c in state)
        if (c.id == updated.id) updated else c,
    ];
  }

  void deleteCar(String id) {
    state = state.where((c) => c.id != id).toList();
  }

  void updateStatus(String id, CarStatus status) {
    state = [
      for (final c in state)
        if (c.id == id) c.copyWith(status: status) else c,
    ];
  }
}

// ─── Filtered providers ───────────────────────────────────────────────────────

@riverpod
List<CarModel> filteredCars(
  FilteredCarsRef ref, {
  String query = '',
  String statusFilter = 'All',
}) {
  final cars = ref.watch(carsNotifierProvider);

  return cars.where((car) {
    // Text search
    final q = query.toLowerCase();
    final matchesQuery = q.isEmpty ||
        car.make.toLowerCase().contains(q) ||
        car.model.toLowerCase().contains(q) ||
        car.vin.toLowerCase().contains(q);

    // Chip filter
    final matchesStatus = switch (statusFilter) {
      'Available' => car.status == CarStatus.available,
      'Reserved' => car.status == CarStatus.reserved,
      'Sold' => car.status == CarStatus.sold,
      'New' => car.condition == CarCondition.newCar,
      'Used' => car.condition == CarCondition.used,
      _ => true, // 'All'
    };

    return matchesQuery && matchesStatus;
  }).toList();
}

// ─── Stats provider ───────────────────────────────────────────────────────────

@riverpod
Map<String, int> carsStats(CarsStatsRef ref) {
  final cars = ref.watch(carsNotifierProvider);
  return {
    'total': cars.length,
    'available': cars.where((c) => c.status == CarStatus.available).length,
    'reserved': cars.where((c) => c.status == CarStatus.reserved).length,
    'sold': cars.where((c) => c.status == CarStatus.sold).length,
  };
}
