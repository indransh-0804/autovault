import 'package:freezed_annotation/freezed_annotation.dart';
part 'car_model.freezed.dart';
part 'car_model.g.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

enum CarCondition {
  @JsonValue('new')
  newCar,
  @JsonValue('used')
  used,
}

enum FuelType {
  @JsonValue('petrol')
  petrol,
  @JsonValue('diesel')
  diesel,
  @JsonValue('electric')
  electric,
  @JsonValue('hybrid')
  hybrid,
}

enum Transmission {
  @JsonValue('automatic')
  automatic,
  @JsonValue('manual')
  manual,
}

enum CarStatus {
  @JsonValue('available')
  available,
  @JsonValue('reserved')
  reserved,
  @JsonValue('sold')
  sold,
}

// ─── Extensions ───────────────────────────────────────────────────────────────

extension CarConditionX on CarCondition {
  String get label => this == CarCondition.newCar ? 'New' : 'Used';
}

extension FuelTypeX on FuelType {
  String get label => switch (this) {
        FuelType.petrol => 'Petrol',
        FuelType.diesel => 'Diesel',
        FuelType.electric => 'EV',
        FuelType.hybrid => 'Hybrid',
      };
}

extension TransmissionX on Transmission {
  String get label => this == Transmission.automatic ? 'Auto' : 'Manual';
}

extension CarStatusX on CarStatus {
  String get label => switch (this) {
        CarStatus.available => 'Available',
        CarStatus.reserved => 'Reserved',
        CarStatus.sold => 'Sold',
      };
}

// ─── Model ────────────────────────────────────────────────────────────────────

@freezed
class CarModel with _$CarModel {
  const factory CarModel({
    required String id,
    required String make,
    required String model,
    required int year,
    required String vin,
    required String color,
    required CarCondition condition,
    required FuelType fuelType,
    required Transmission transmission,
    @Default(0) int mileage,
    required double purchasePrice,
    required double sellingPrice,
    @Default(CarStatus.available) CarStatus status,
    @Default([]) List<String> imageUrls,
    @Default('') String description,
    required DateTime createdAt,
  }) = _CarModel;

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
}
