import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_model.freezed.dart';
part 'customer_model.g.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

enum LeadStatus {
  @JsonValue('hot_lead')
  hotLead,
  @JsonValue('follow_up')
  followUp,
  @JsonValue('converted')
  converted,
  @JsonValue('inactive')
  inactive,
}

extension LeadStatusX on LeadStatus {
  String get label => switch (this) {
        LeadStatus.hotLead => 'Hot Lead',
        LeadStatus.followUp => 'Follow-up',
        LeadStatus.converted => 'Converted',
        LeadStatus.inactive => 'Inactive',
      };
}

// ─── Model ────────────────────────────────────────────────────────────────────

@freezed
class CustomerModel with _$CustomerModel {
  const CustomerModel._();

  const factory CustomerModel({
    required String id,
    required String firstName,
    required String lastName,
    required String phone,
    @Default('') String email,
    DateTime? dateOfBirth,
    @Default('') String address,
    @Default('') String assignedEmployeeId,
    @Default('') String assignedEmployeeName,
    @Default(LeadStatus.hotLead) LeadStatus leadStatus,
    @Default('') String notes,
    @Default([]) List<String> purchaseIds,
    @Default([]) List<String> loanIds,
    @Default([]) List<String> testDriveIds,
    required DateTime createdAt,
    required DateTime lastInteractionAt,
  }) = _CustomerModel;

  // Computed
  String get fullName => '$firstName $lastName';

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
}
