// data/models/add_on_model.dart
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_on_model.freezed.dart';
part 'add_on_model.g.dart';

@freezed
class AddOnModel with _$AddOnModel {
  const factory AddOnModel({
    required String id,
    required String name,
    required double price,
    @Default(false) bool isCustom,
  }) = _AddOnModel;

  factory AddOnModel.fromJson(Map<String, dynamic> json) =>
      _$AddOnModelFromJson(json);
}

// ─── Pre-defined showroom add-ons ────────────────────────────────────────────

final predefinedAddOns = <AddOnModel>[
  const AddOnModel(id: 'ao_001', name: 'Extended Warranty',    price: 15000),
  const AddOnModel(id: 'ao_002', name: 'Paint Protection Film', price: 8000),
  const AddOnModel(id: 'ao_003', name: 'Car Cover',            price: 2500),
  const AddOnModel(id: 'ao_004', name: 'Floor Mats Set',       price: 3000),
  const AddOnModel(id: 'ao_005', name: 'Reverse Camera',       price: 6500),
  const AddOnModel(id: 'ao_006', name: 'Infotainment Upgrade', price: 12000),
];
