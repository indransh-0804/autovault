/// Car inventory data model with specifications and status tracking.
///
/// This file defines the car model used for inventory management, including:
/// - Vehicle specifications (make, model, year, VIN, etc.)
/// - Condition and status tracking (new/used, available/reserved/sold)
/// - Pricing information (purchase and selling prices)
/// - Image gallery storage
///
/// The model uses Freezed for immutability and includes enums for
/// standardized categorization of vehicle attributes.
library;

import 'package:freezed_annotation/freezed_annotation.dart';
part 'car_model.freezed.dart';
part 'car_model.g.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

/// Vehicle condition enumeration.
///
/// Distinguishes between new vehicles (directly from manufacturer/dealer)
/// and used/pre-owned vehicles (previously owned by customers).
enum CarCondition {
  /// Brand new vehicle never previously owned.
  @JsonValue('new')
  newCar,

  /// Used/pre-owned vehicle with previous ownership history.
  @JsonValue('used')
  used,
}

/// Fuel type enumeration for vehicle powertrains.
///
/// Covers the major fuel types available in the Indian automobile market.
enum FuelType {
  /// Petrol/gasoline engine.
  @JsonValue('petrol')
  petrol,

  /// Diesel engine.
  @JsonValue('diesel')
  diesel,

  /// Electric vehicle (EV) with battery power.
  @JsonValue('electric')
  electric,

  /// Hybrid vehicle combining combustion engine with electric motor.
  @JsonValue('hybrid')
  hybrid,
}

/// Transmission type enumeration.
///
/// Defines the gear shifting mechanism of the vehicle.
enum Transmission {
  /// Automatic transmission (self-shifting).
  @JsonValue('automatic')
  automatic,

  /// Manual transmission (manual gear selection).
  @JsonValue('manual')
  manual,
}

/// Car availability status in the inventory.
///
/// Tracks the car's position in the sales pipeline from listing to sale.
enum CarStatus {
  /// Available for immediate purchase.
  ///
  /// The car is in inventory, visible to customers, and can be reserved
  /// for test drives or purchased.
  @JsonValue('available')
  available,

  /// Reserved for a specific customer.
  ///
  /// A customer has shown strong interest and the car is temporarily
  /// held (e.g., pending down payment or loan approval).
  @JsonValue('reserved')
  reserved,

  /// Sold and no longer available.
  ///
  /// The purchase transaction has been completed. The car remains in
  /// the system for historical records but is not shown in active inventory.
  @JsonValue('sold')
  sold,
}

// ─── Extensions ───────────────────────────────────────────────────────────────

/// Extension for [CarCondition] to provide display labels.
extension CarConditionX on CarCondition {
  /// Returns user-friendly label for the condition.
  String get label => this == CarCondition.newCar ? 'New' : 'Used';
}

/// Extension for [FuelType] to provide display labels.
extension FuelTypeX on FuelType {
  /// Returns user-friendly label for the fuel type.
  ///
  /// Note: "EV" is used instead of "Electric" for brevity in UI displays.
  String get label => switch (this) {
        FuelType.petrol => 'Petrol',
        FuelType.diesel => 'Diesel',
        FuelType.electric => 'EV',
        FuelType.hybrid => 'Hybrid',
      };
}

/// Extension for [Transmission] to provide display labels.
extension TransmissionX on Transmission {
  /// Returns user-friendly label for the transmission type.
  ///
  /// Note: "Auto" is used instead of "Automatic" for brevity in UI displays.
  String get label => this == Transmission.automatic ? 'Auto' : 'Manual';
}

/// Extension for [CarStatus] to provide display labels.
extension CarStatusX on CarStatus {
  /// Returns user-friendly label for the status.
  String get label => switch (this) {
        CarStatus.available => 'Available',
        CarStatus.reserved => 'Reserved',
        CarStatus.sold => 'Sold',
      };
}

// ─── Model ────────────────────────────────────────────────────────────────────

/// Car inventory model representing a vehicle in the showroom's stock.
///
/// Stores complete vehicle information including specifications, pricing,
/// status, and images. Used throughout the app for:
/// - Inventory management (listing, filtering, searching)
/// - Test drive scheduling (car selection)
/// - Purchase transactions (car details in invoices)
/// - Analytics and reporting
///
/// ## Storage
///
/// Cars are stored in Firestore under `cars/{carId}` with:
/// - Images stored in Firebase Storage at `cars/{carId}/{imageName}`
/// - Full-text search enabled on make, model, VIN (future feature)
///
/// ## Status Flow
///
/// 1. **Available**: Listed in inventory, visible to customers
/// 2. **Reserved**: Temporarily held for specific customer
/// 3. **Sold**: Purchase completed, moves to historical records
@freezed
class CarModel with _$CarModel {
  const factory CarModel({
    /// Unique identifier for the car.
    required String id,

    /// Vehicle manufacturer/brand (e.g., "Maruti Suzuki", "Hyundai").
    required String make,

    /// Model name (e.g., "Swift", "i20").
    required String model,

    /// Manufacturing year (e.g., 2024, 2023).
    required int year,

    /// Vehicle Identification Number (VIN) - unique 17-character code.
    required String vin,

    /// Exterior color of the vehicle.
    required String color,

    /// Condition: new or used.
    required CarCondition condition,

    /// Fuel/powertrain type.
    required FuelType fuelType,

    /// Transmission type.
    required Transmission transmission,

    /// Mileage/odometer reading in kilometers.
    @Default(0) int mileage,

    /// Price paid by showroom to acquire this car (in rupees).
    ///
    /// Used for profit calculation and inventory valuation.
    /// Visible only to owners.
    required double purchasePrice,

    /// Selling price listed for customers (in rupees).
    ///
    /// GST (28%) is calculated on top during checkout.
    required double sellingPrice,

    /// Current status in the sales pipeline.
    @Default(CarStatus.available) CarStatus status,

    /// List of image URLs from Firebase Storage (up to 6 images).
    @Default([]) List<String> imageUrls,

    /// Marketing description of the vehicle (optional).
    @Default('') String description,

    /// Timestamp when this car was added to inventory.
    required DateTime createdAt,
  }) = _CarModel;

  /// Creates a [CarModel] from a JSON map.
  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
}
