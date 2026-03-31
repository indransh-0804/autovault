// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_drive_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestDriveModel _$TestDriveModelFromJson(Map<String, dynamic> json) {
  return _TestDriveModel.fromJson(json);
}

/// @nodoc
mixin _$TestDriveModel {
  String get id => throw _privateConstructorUsedError; // Customer snapshot
  String get customerId => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String get customerPhone =>
      throw _privateConstructorUsedError; // Car snapshot
  String get carId => throw _privateConstructorUsedError;
  String get carMake => throw _privateConstructorUsedError;
  String get carModel => throw _privateConstructorUsedError;
  int get carYear => throw _privateConstructorUsedError; // Assignment
  String get assignedEmployeeId => throw _privateConstructorUsedError;
  String get assignedEmployeeName =>
      throw _privateConstructorUsedError; // Schedule
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  TestDriveStatus get status => throw _privateConstructorUsedError; // Details
  String get location => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  List<TestDriveActivityModel> get activityLog =>
      throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get convertedToPurchaseId => throw _privateConstructorUsedError;

  /// Serializes this TestDriveModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestDriveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestDriveModelCopyWith<TestDriveModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestDriveModelCopyWith<$Res> {
  factory $TestDriveModelCopyWith(
          TestDriveModel value, $Res Function(TestDriveModel) then) =
      _$TestDriveModelCopyWithImpl<$Res, TestDriveModel>;
  @useResult
  $Res call(
      {String id,
      String customerId,
      String customerName,
      String customerPhone,
      String carId,
      String carMake,
      String carModel,
      int carYear,
      String assignedEmployeeId,
      String assignedEmployeeName,
      DateTime scheduledAt,
      int durationMinutes,
      TestDriveStatus status,
      String location,
      String notes,
      List<TestDriveActivityModel> activityLog,
      DateTime createdAt,
      String? convertedToPurchaseId});
}

/// @nodoc
class _$TestDriveModelCopyWithImpl<$Res, $Val extends TestDriveModel>
    implements $TestDriveModelCopyWith<$Res> {
  _$TestDriveModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestDriveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? customerPhone = null,
    Object? carId = null,
    Object? carMake = null,
    Object? carModel = null,
    Object? carYear = null,
    Object? assignedEmployeeId = null,
    Object? assignedEmployeeName = null,
    Object? scheduledAt = null,
    Object? durationMinutes = null,
    Object? status = null,
    Object? location = null,
    Object? notes = null,
    Object? activityLog = null,
    Object? createdAt = null,
    Object? convertedToPurchaseId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      customerPhone: null == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String,
      carId: null == carId
          ? _value.carId
          : carId // ignore: cast_nullable_to_non_nullable
              as String,
      carMake: null == carMake
          ? _value.carMake
          : carMake // ignore: cast_nullable_to_non_nullable
              as String,
      carModel: null == carModel
          ? _value.carModel
          : carModel // ignore: cast_nullable_to_non_nullable
              as String,
      carYear: null == carYear
          ? _value.carYear
          : carYear // ignore: cast_nullable_to_non_nullable
              as int,
      assignedEmployeeId: null == assignedEmployeeId
          ? _value.assignedEmployeeId
          : assignedEmployeeId // ignore: cast_nullable_to_non_nullable
              as String,
      assignedEmployeeName: null == assignedEmployeeName
          ? _value.assignedEmployeeName
          : assignedEmployeeName // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TestDriveStatus,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      activityLog: null == activityLog
          ? _value.activityLog
          : activityLog // ignore: cast_nullable_to_non_nullable
              as List<TestDriveActivityModel>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      convertedToPurchaseId: freezed == convertedToPurchaseId
          ? _value.convertedToPurchaseId
          : convertedToPurchaseId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestDriveModelImplCopyWith<$Res>
    implements $TestDriveModelCopyWith<$Res> {
  factory _$$TestDriveModelImplCopyWith(_$TestDriveModelImpl value,
          $Res Function(_$TestDriveModelImpl) then) =
      __$$TestDriveModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String customerId,
      String customerName,
      String customerPhone,
      String carId,
      String carMake,
      String carModel,
      int carYear,
      String assignedEmployeeId,
      String assignedEmployeeName,
      DateTime scheduledAt,
      int durationMinutes,
      TestDriveStatus status,
      String location,
      String notes,
      List<TestDriveActivityModel> activityLog,
      DateTime createdAt,
      String? convertedToPurchaseId});
}

/// @nodoc
class __$$TestDriveModelImplCopyWithImpl<$Res>
    extends _$TestDriveModelCopyWithImpl<$Res, _$TestDriveModelImpl>
    implements _$$TestDriveModelImplCopyWith<$Res> {
  __$$TestDriveModelImplCopyWithImpl(
      _$TestDriveModelImpl _value, $Res Function(_$TestDriveModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestDriveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? customerPhone = null,
    Object? carId = null,
    Object? carMake = null,
    Object? carModel = null,
    Object? carYear = null,
    Object? assignedEmployeeId = null,
    Object? assignedEmployeeName = null,
    Object? scheduledAt = null,
    Object? durationMinutes = null,
    Object? status = null,
    Object? location = null,
    Object? notes = null,
    Object? activityLog = null,
    Object? createdAt = null,
    Object? convertedToPurchaseId = freezed,
  }) {
    return _then(_$TestDriveModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      customerPhone: null == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String,
      carId: null == carId
          ? _value.carId
          : carId // ignore: cast_nullable_to_non_nullable
              as String,
      carMake: null == carMake
          ? _value.carMake
          : carMake // ignore: cast_nullable_to_non_nullable
              as String,
      carModel: null == carModel
          ? _value.carModel
          : carModel // ignore: cast_nullable_to_non_nullable
              as String,
      carYear: null == carYear
          ? _value.carYear
          : carYear // ignore: cast_nullable_to_non_nullable
              as int,
      assignedEmployeeId: null == assignedEmployeeId
          ? _value.assignedEmployeeId
          : assignedEmployeeId // ignore: cast_nullable_to_non_nullable
              as String,
      assignedEmployeeName: null == assignedEmployeeName
          ? _value.assignedEmployeeName
          : assignedEmployeeName // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TestDriveStatus,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      activityLog: null == activityLog
          ? _value._activityLog
          : activityLog // ignore: cast_nullable_to_non_nullable
              as List<TestDriveActivityModel>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      convertedToPurchaseId: freezed == convertedToPurchaseId
          ? _value.convertedToPurchaseId
          : convertedToPurchaseId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestDriveModelImpl extends _TestDriveModel {
  const _$TestDriveModelImpl(
      {required this.id,
      required this.customerId,
      required this.customerName,
      required this.customerPhone,
      required this.carId,
      required this.carMake,
      required this.carModel,
      required this.carYear,
      required this.assignedEmployeeId,
      required this.assignedEmployeeName,
      required this.scheduledAt,
      this.durationMinutes = 30,
      this.status = TestDriveStatus.pending,
      this.location = '',
      this.notes = '',
      final List<TestDriveActivityModel> activityLog = const [],
      required this.createdAt,
      this.convertedToPurchaseId})
      : _activityLog = activityLog,
        super._();

  factory _$TestDriveModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestDriveModelImplFromJson(json);

  @override
  final String id;
// Customer snapshot
  @override
  final String customerId;
  @override
  final String customerName;
  @override
  final String customerPhone;
// Car snapshot
  @override
  final String carId;
  @override
  final String carMake;
  @override
  final String carModel;
  @override
  final int carYear;
// Assignment
  @override
  final String assignedEmployeeId;
  @override
  final String assignedEmployeeName;
// Schedule
  @override
  final DateTime scheduledAt;
  @override
  @JsonKey()
  final int durationMinutes;
  @override
  @JsonKey()
  final TestDriveStatus status;
// Details
  @override
  @JsonKey()
  final String location;
  @override
  @JsonKey()
  final String notes;
  final List<TestDriveActivityModel> _activityLog;
  @override
  @JsonKey()
  List<TestDriveActivityModel> get activityLog {
    if (_activityLog is EqualUnmodifiableListView) return _activityLog;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activityLog);
  }

  @override
  final DateTime createdAt;
  @override
  final String? convertedToPurchaseId;

  @override
  String toString() {
    return 'TestDriveModel(id: $id, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, carId: $carId, carMake: $carMake, carModel: $carModel, carYear: $carYear, assignedEmployeeId: $assignedEmployeeId, assignedEmployeeName: $assignedEmployeeName, scheduledAt: $scheduledAt, durationMinutes: $durationMinutes, status: $status, location: $location, notes: $notes, activityLog: $activityLog, createdAt: $createdAt, convertedToPurchaseId: $convertedToPurchaseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDriveModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.carId, carId) || other.carId == carId) &&
            (identical(other.carMake, carMake) || other.carMake == carMake) &&
            (identical(other.carModel, carModel) ||
                other.carModel == carModel) &&
            (identical(other.carYear, carYear) || other.carYear == carYear) &&
            (identical(other.assignedEmployeeId, assignedEmployeeId) ||
                other.assignedEmployeeId == assignedEmployeeId) &&
            (identical(other.assignedEmployeeName, assignedEmployeeName) ||
                other.assignedEmployeeName == assignedEmployeeName) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._activityLog, _activityLog) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.convertedToPurchaseId, convertedToPurchaseId) ||
                other.convertedToPurchaseId == convertedToPurchaseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      customerId,
      customerName,
      customerPhone,
      carId,
      carMake,
      carModel,
      carYear,
      assignedEmployeeId,
      assignedEmployeeName,
      scheduledAt,
      durationMinutes,
      status,
      location,
      notes,
      const DeepCollectionEquality().hash(_activityLog),
      createdAt,
      convertedToPurchaseId);

  /// Create a copy of TestDriveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestDriveModelImplCopyWith<_$TestDriveModelImpl> get copyWith =>
      __$$TestDriveModelImplCopyWithImpl<_$TestDriveModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestDriveModelImplToJson(
      this,
    );
  }
}

abstract class _TestDriveModel extends TestDriveModel {
  const factory _TestDriveModel(
      {required final String id,
      required final String customerId,
      required final String customerName,
      required final String customerPhone,
      required final String carId,
      required final String carMake,
      required final String carModel,
      required final int carYear,
      required final String assignedEmployeeId,
      required final String assignedEmployeeName,
      required final DateTime scheduledAt,
      final int durationMinutes,
      final TestDriveStatus status,
      final String location,
      final String notes,
      final List<TestDriveActivityModel> activityLog,
      required final DateTime createdAt,
      final String? convertedToPurchaseId}) = _$TestDriveModelImpl;
  const _TestDriveModel._() : super._();

  factory _TestDriveModel.fromJson(Map<String, dynamic> json) =
      _$TestDriveModelImpl.fromJson;

  @override
  String get id; // Customer snapshot
  @override
  String get customerId;
  @override
  String get customerName;
  @override
  String get customerPhone; // Car snapshot
  @override
  String get carId;
  @override
  String get carMake;
  @override
  String get carModel;
  @override
  int get carYear; // Assignment
  @override
  String get assignedEmployeeId;
  @override
  String get assignedEmployeeName; // Schedule
  @override
  DateTime get scheduledAt;
  @override
  int get durationMinutes;
  @override
  TestDriveStatus get status; // Details
  @override
  String get location;
  @override
  String get notes;
  @override
  List<TestDriveActivityModel> get activityLog;
  @override
  DateTime get createdAt;
  @override
  String? get convertedToPurchaseId;

  /// Create a copy of TestDriveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestDriveModelImplCopyWith<_$TestDriveModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
