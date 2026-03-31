// data/models/interaction_model.dart
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'interaction_model.freezed.dart';
part 'interaction_model.g.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

enum InteractionType {
  @JsonValue('call')       call,
  @JsonValue('visit')      visit,
  @JsonValue('test_drive') testDrive,
  @JsonValue('purchase')   purchase,
}

extension InteractionTypeX on InteractionType {
  String get label => switch (this) {
        InteractionType.call      => 'Call',
        InteractionType.visit     => 'Visit',
        InteractionType.testDrive => 'Test Drive',
        InteractionType.purchase  => 'Purchase',
      };

  String get emoji => switch (this) {
        InteractionType.call      => '📞',
        InteractionType.visit     => '🏢',
        InteractionType.testDrive => '🚗',
        InteractionType.purchase  => '🤝',
      };
}

// ─── Model ────────────────────────────────────────────────────────────────────

@freezed
class InteractionModel with _$InteractionModel {
  const factory InteractionModel({
    required String id,
    required String customerId,
    required InteractionType type,
    required String note,
    required DateTime timestamp,
  }) = _InteractionModel;

  factory InteractionModel.fromJson(Map<String, dynamic> json) =>
      _$InteractionModelFromJson(json);
}
