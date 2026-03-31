import 'package:freezed_annotation/freezed_annotation.dart';
part 'part_model.freezed.dart';
part 'part_model.g.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

enum PartCategory {
  @JsonValue('engine')
  engine,
  @JsonValue('brakes')
  brakes,
  @JsonValue('electrical')
  electrical,
  @JsonValue('body')
  body,
  @JsonValue('tyres')
  tyres,
  @JsonValue('interior')
  interior,
  @JsonValue('other')
  other,
}

extension PartCategoryX on PartCategory {
  String get label => switch (this) {
        PartCategory.engine => 'Engine',
        PartCategory.brakes => 'Brakes',
        PartCategory.electrical => 'Electrical',
        PartCategory.body => 'Body',
        PartCategory.tyres => 'Tyres',
        PartCategory.interior => 'Interior',
        PartCategory.other => 'Other',
      };
}

// ─── Model ────────────────────────────────────────────────────────────────────

@freezed
class PartModel with _$PartModel {
  const factory PartModel({
    required String id,
    required String name,
    required String partNumber,
    required PartCategory category,
    required String supplierId,
    required String supplierName,
    required int quantity,
    required int reorderLevel,
    required double unitPrice,
    @Default('') String description,
    required DateTime createdAt,
  }) = _PartModel;

  factory PartModel.fromJson(Map<String, dynamic> json) =>
      _$PartModelFromJson(json);
}

// ─── Computed helpers ─────────────────────────────────────────────────────────

enum StockStatus { inStock, lowStock, outOfStock }

extension PartModelX on PartModel {
  StockStatus get stockStatus {
    if (quantity <= 0) return StockStatus.outOfStock;
    if (quantity <= reorderLevel) return StockStatus.lowStock;
    return StockStatus.inStock;
  }

  String get stockLabel => switch (stockStatus) {
        StockStatus.inStock => 'In Stock',
        StockStatus.lowStock => 'Low Stock',
        StockStatus.outOfStock => 'Out of Stock',
      };
}
