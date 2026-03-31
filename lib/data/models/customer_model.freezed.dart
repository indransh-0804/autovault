// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) {
  return _CustomerModel.fromJson(json);
}

/// @nodoc
mixin _$CustomerModel {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get assignedEmployeeId => throw _privateConstructorUsedError;
  String get assignedEmployeeName => throw _privateConstructorUsedError;
  LeadStatus get leadStatus => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  List<String> get purchaseIds => throw _privateConstructorUsedError;
  List<String> get loanIds => throw _privateConstructorUsedError;
  List<String> get testDriveIds => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get lastInteractionAt => throw _privateConstructorUsedError;

  /// Serializes this CustomerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerModelCopyWith<CustomerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerModelCopyWith<$Res> {
  factory $CustomerModelCopyWith(
          CustomerModel value, $Res Function(CustomerModel) then) =
      _$CustomerModelCopyWithImpl<$Res, CustomerModel>;
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String phone,
      String email,
      DateTime? dateOfBirth,
      String address,
      String assignedEmployeeId,
      String assignedEmployeeName,
      LeadStatus leadStatus,
      String notes,
      List<String> purchaseIds,
      List<String> loanIds,
      List<String> testDriveIds,
      DateTime createdAt,
      DateTime lastInteractionAt});
}

/// @nodoc
class _$CustomerModelCopyWithImpl<$Res, $Val extends CustomerModel>
    implements $CustomerModelCopyWith<$Res> {
  _$CustomerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? email = null,
    Object? dateOfBirth = freezed,
    Object? address = null,
    Object? assignedEmployeeId = null,
    Object? assignedEmployeeName = null,
    Object? leadStatus = null,
    Object? notes = null,
    Object? purchaseIds = null,
    Object? loanIds = null,
    Object? testDriveIds = null,
    Object? createdAt = null,
    Object? lastInteractionAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      assignedEmployeeId: null == assignedEmployeeId
          ? _value.assignedEmployeeId
          : assignedEmployeeId // ignore: cast_nullable_to_non_nullable
              as String,
      assignedEmployeeName: null == assignedEmployeeName
          ? _value.assignedEmployeeName
          : assignedEmployeeName // ignore: cast_nullable_to_non_nullable
              as String,
      leadStatus: null == leadStatus
          ? _value.leadStatus
          : leadStatus // ignore: cast_nullable_to_non_nullable
              as LeadStatus,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseIds: null == purchaseIds
          ? _value.purchaseIds
          : purchaseIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      loanIds: null == loanIds
          ? _value.loanIds
          : loanIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      testDriveIds: null == testDriveIds
          ? _value.testDriveIds
          : testDriveIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastInteractionAt: null == lastInteractionAt
          ? _value.lastInteractionAt
          : lastInteractionAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerModelImplCopyWith<$Res>
    implements $CustomerModelCopyWith<$Res> {
  factory _$$CustomerModelImplCopyWith(
          _$CustomerModelImpl value, $Res Function(_$CustomerModelImpl) then) =
      __$$CustomerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String phone,
      String email,
      DateTime? dateOfBirth,
      String address,
      String assignedEmployeeId,
      String assignedEmployeeName,
      LeadStatus leadStatus,
      String notes,
      List<String> purchaseIds,
      List<String> loanIds,
      List<String> testDriveIds,
      DateTime createdAt,
      DateTime lastInteractionAt});
}

/// @nodoc
class __$$CustomerModelImplCopyWithImpl<$Res>
    extends _$CustomerModelCopyWithImpl<$Res, _$CustomerModelImpl>
    implements _$$CustomerModelImplCopyWith<$Res> {
  __$$CustomerModelImplCopyWithImpl(
      _$CustomerModelImpl _value, $Res Function(_$CustomerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? email = null,
    Object? dateOfBirth = freezed,
    Object? address = null,
    Object? assignedEmployeeId = null,
    Object? assignedEmployeeName = null,
    Object? leadStatus = null,
    Object? notes = null,
    Object? purchaseIds = null,
    Object? loanIds = null,
    Object? testDriveIds = null,
    Object? createdAt = null,
    Object? lastInteractionAt = null,
  }) {
    return _then(_$CustomerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      assignedEmployeeId: null == assignedEmployeeId
          ? _value.assignedEmployeeId
          : assignedEmployeeId // ignore: cast_nullable_to_non_nullable
              as String,
      assignedEmployeeName: null == assignedEmployeeName
          ? _value.assignedEmployeeName
          : assignedEmployeeName // ignore: cast_nullable_to_non_nullable
              as String,
      leadStatus: null == leadStatus
          ? _value.leadStatus
          : leadStatus // ignore: cast_nullable_to_non_nullable
              as LeadStatus,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseIds: null == purchaseIds
          ? _value._purchaseIds
          : purchaseIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      loanIds: null == loanIds
          ? _value._loanIds
          : loanIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      testDriveIds: null == testDriveIds
          ? _value._testDriveIds
          : testDriveIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastInteractionAt: null == lastInteractionAt
          ? _value.lastInteractionAt
          : lastInteractionAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerModelImpl extends _CustomerModel {
  const _$CustomerModelImpl(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      this.email = '',
      this.dateOfBirth,
      this.address = '',
      this.assignedEmployeeId = '',
      this.assignedEmployeeName = '',
      this.leadStatus = LeadStatus.hotLead,
      this.notes = '',
      final List<String> purchaseIds = const [],
      final List<String> loanIds = const [],
      final List<String> testDriveIds = const [],
      required this.createdAt,
      required this.lastInteractionAt})
      : _purchaseIds = purchaseIds,
        _loanIds = loanIds,
        _testDriveIds = testDriveIds,
        super._();

  factory _$CustomerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerModelImplFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String phone;
  @override
  @JsonKey()
  final String email;
  @override
  final DateTime? dateOfBirth;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String assignedEmployeeId;
  @override
  @JsonKey()
  final String assignedEmployeeName;
  @override
  @JsonKey()
  final LeadStatus leadStatus;
  @override
  @JsonKey()
  final String notes;
  final List<String> _purchaseIds;
  @override
  @JsonKey()
  List<String> get purchaseIds {
    if (_purchaseIds is EqualUnmodifiableListView) return _purchaseIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_purchaseIds);
  }

  final List<String> _loanIds;
  @override
  @JsonKey()
  List<String> get loanIds {
    if (_loanIds is EqualUnmodifiableListView) return _loanIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loanIds);
  }

  final List<String> _testDriveIds;
  @override
  @JsonKey()
  List<String> get testDriveIds {
    if (_testDriveIds is EqualUnmodifiableListView) return _testDriveIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_testDriveIds);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime lastInteractionAt;

  @override
  String toString() {
    return 'CustomerModel(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, dateOfBirth: $dateOfBirth, address: $address, assignedEmployeeId: $assignedEmployeeId, assignedEmployeeName: $assignedEmployeeName, leadStatus: $leadStatus, notes: $notes, purchaseIds: $purchaseIds, loanIds: $loanIds, testDriveIds: $testDriveIds, createdAt: $createdAt, lastInteractionAt: $lastInteractionAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.assignedEmployeeId, assignedEmployeeId) ||
                other.assignedEmployeeId == assignedEmployeeId) &&
            (identical(other.assignedEmployeeName, assignedEmployeeName) ||
                other.assignedEmployeeName == assignedEmployeeName) &&
            (identical(other.leadStatus, leadStatus) ||
                other.leadStatus == leadStatus) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._purchaseIds, _purchaseIds) &&
            const DeepCollectionEquality().equals(other._loanIds, _loanIds) &&
            const DeepCollectionEquality()
                .equals(other._testDriveIds, _testDriveIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastInteractionAt, lastInteractionAt) ||
                other.lastInteractionAt == lastInteractionAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstName,
      lastName,
      phone,
      email,
      dateOfBirth,
      address,
      assignedEmployeeId,
      assignedEmployeeName,
      leadStatus,
      notes,
      const DeepCollectionEquality().hash(_purchaseIds),
      const DeepCollectionEquality().hash(_loanIds),
      const DeepCollectionEquality().hash(_testDriveIds),
      createdAt,
      lastInteractionAt);

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerModelImplCopyWith<_$CustomerModelImpl> get copyWith =>
      __$$CustomerModelImplCopyWithImpl<_$CustomerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerModelImplToJson(
      this,
    );
  }
}

abstract class _CustomerModel extends CustomerModel {
  const factory _CustomerModel(
      {required final String id,
      required final String firstName,
      required final String lastName,
      required final String phone,
      final String email,
      final DateTime? dateOfBirth,
      final String address,
      final String assignedEmployeeId,
      final String assignedEmployeeName,
      final LeadStatus leadStatus,
      final String notes,
      final List<String> purchaseIds,
      final List<String> loanIds,
      final List<String> testDriveIds,
      required final DateTime createdAt,
      required final DateTime lastInteractionAt}) = _$CustomerModelImpl;
  const _CustomerModel._() : super._();

  factory _CustomerModel.fromJson(Map<String, dynamic> json) =
      _$CustomerModelImpl.fromJson;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get phone;
  @override
  String get email;
  @override
  DateTime? get dateOfBirth;
  @override
  String get address;
  @override
  String get assignedEmployeeId;
  @override
  String get assignedEmployeeName;
  @override
  LeadStatus get leadStatus;
  @override
  String get notes;
  @override
  List<String> get purchaseIds;
  @override
  List<String> get loanIds;
  @override
  List<String> get testDriveIds;
  @override
  DateTime get createdAt;
  @override
  DateTime get lastInteractionAt;

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerModelImplCopyWith<_$CustomerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
