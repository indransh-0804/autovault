// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CarSnapshot _$CarSnapshotFromJson(Map<String, dynamic> json) {
  return _CarSnapshot.fromJson(json);
}

/// @nodoc
mixin _$CarSnapshot {
  String get carId => throw _privateConstructorUsedError;
  String get make => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  String get vin => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  double get sellingPrice => throw _privateConstructorUsedError;

  /// Serializes this CarSnapshot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CarSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CarSnapshotCopyWith<CarSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarSnapshotCopyWith<$Res> {
  factory $CarSnapshotCopyWith(
          CarSnapshot value, $Res Function(CarSnapshot) then) =
      _$CarSnapshotCopyWithImpl<$Res, CarSnapshot>;
  @useResult
  $Res call(
      {String carId,
      String make,
      String model,
      int year,
      String vin,
      String color,
      double sellingPrice});
}

/// @nodoc
class _$CarSnapshotCopyWithImpl<$Res, $Val extends CarSnapshot>
    implements $CarSnapshotCopyWith<$Res> {
  _$CarSnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CarSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carId = null,
    Object? make = null,
    Object? model = null,
    Object? year = null,
    Object? vin = null,
    Object? color = null,
    Object? sellingPrice = null,
  }) {
    return _then(_value.copyWith(
      carId: null == carId
          ? _value.carId
          : carId // ignore: cast_nullable_to_non_nullable
              as String,
      make: null == make
          ? _value.make
          : make // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      vin: null == vin
          ? _value.vin
          : vin // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      sellingPrice: null == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CarSnapshotImplCopyWith<$Res>
    implements $CarSnapshotCopyWith<$Res> {
  factory _$$CarSnapshotImplCopyWith(
          _$CarSnapshotImpl value, $Res Function(_$CarSnapshotImpl) then) =
      __$$CarSnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String carId,
      String make,
      String model,
      int year,
      String vin,
      String color,
      double sellingPrice});
}

/// @nodoc
class __$$CarSnapshotImplCopyWithImpl<$Res>
    extends _$CarSnapshotCopyWithImpl<$Res, _$CarSnapshotImpl>
    implements _$$CarSnapshotImplCopyWith<$Res> {
  __$$CarSnapshotImplCopyWithImpl(
      _$CarSnapshotImpl _value, $Res Function(_$CarSnapshotImpl) _then)
      : super(_value, _then);

  /// Create a copy of CarSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carId = null,
    Object? make = null,
    Object? model = null,
    Object? year = null,
    Object? vin = null,
    Object? color = null,
    Object? sellingPrice = null,
  }) {
    return _then(_$CarSnapshotImpl(
      carId: null == carId
          ? _value.carId
          : carId // ignore: cast_nullable_to_non_nullable
              as String,
      make: null == make
          ? _value.make
          : make // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      vin: null == vin
          ? _value.vin
          : vin // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      sellingPrice: null == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CarSnapshotImpl implements _CarSnapshot {
  const _$CarSnapshotImpl(
      {required this.carId,
      required this.make,
      required this.model,
      required this.year,
      required this.vin,
      required this.color,
      required this.sellingPrice});

  factory _$CarSnapshotImpl.fromJson(Map<String, dynamic> json) =>
      _$$CarSnapshotImplFromJson(json);

  @override
  final String carId;
  @override
  final String make;
  @override
  final String model;
  @override
  final int year;
  @override
  final String vin;
  @override
  final String color;
  @override
  final double sellingPrice;

  @override
  String toString() {
    return 'CarSnapshot(carId: $carId, make: $make, model: $model, year: $year, vin: $vin, color: $color, sellingPrice: $sellingPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarSnapshotImpl &&
            (identical(other.carId, carId) || other.carId == carId) &&
            (identical(other.make, make) || other.make == make) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.vin, vin) || other.vin == vin) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, carId, make, model, year, vin, color, sellingPrice);

  /// Create a copy of CarSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CarSnapshotImplCopyWith<_$CarSnapshotImpl> get copyWith =>
      __$$CarSnapshotImplCopyWithImpl<_$CarSnapshotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CarSnapshotImplToJson(
      this,
    );
  }
}

abstract class _CarSnapshot implements CarSnapshot {
  const factory _CarSnapshot(
      {required final String carId,
      required final String make,
      required final String model,
      required final int year,
      required final String vin,
      required final String color,
      required final double sellingPrice}) = _$CarSnapshotImpl;

  factory _CarSnapshot.fromJson(Map<String, dynamic> json) =
      _$CarSnapshotImpl.fromJson;

  @override
  String get carId;
  @override
  String get make;
  @override
  String get model;
  @override
  int get year;
  @override
  String get vin;
  @override
  String get color;
  @override
  double get sellingPrice;

  /// Create a copy of CarSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CarSnapshotImplCopyWith<_$CarSnapshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchaseModel _$PurchaseModelFromJson(Map<String, dynamic> json) {
  return _PurchaseModel.fromJson(json);
}

/// @nodoc
mixin _$PurchaseModel {
  String get id => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  CarSnapshot get carDetails => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String get employeeName => throw _privateConstructorUsedError;
  List<AddOnModel> get addOns => throw _privateConstructorUsedError;
  DiscountType get discountType => throw _privateConstructorUsedError;
  double get discountValue => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  double get gstAmount => throw _privateConstructorUsedError;
  double get gstRate => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  double get downPayment => throw _privateConstructorUsedError;
  String? get loanId => throw _privateConstructorUsedError;
  PurchaseStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PurchaseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseModelCopyWith<PurchaseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseModelCopyWith<$Res> {
  factory $PurchaseModelCopyWith(
          PurchaseModel value, $Res Function(PurchaseModel) then) =
      _$PurchaseModelCopyWithImpl<$Res, PurchaseModel>;
  @useResult
  $Res call(
      {String id,
      String customerId,
      String customerName,
      CarSnapshot carDetails,
      String employeeId,
      String employeeName,
      List<AddOnModel> addOns,
      DiscountType discountType,
      double discountValue,
      double subtotal,
      double gstAmount,
      double gstRate,
      double totalAmount,
      PaymentMethod paymentMethod,
      double downPayment,
      String? loanId,
      PurchaseStatus status,
      DateTime createdAt});

  $CarSnapshotCopyWith<$Res> get carDetails;
}

/// @nodoc
class _$PurchaseModelCopyWithImpl<$Res, $Val extends PurchaseModel>
    implements $PurchaseModelCopyWith<$Res> {
  _$PurchaseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? carDetails = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? addOns = null,
    Object? discountType = null,
    Object? discountValue = null,
    Object? subtotal = null,
    Object? gstAmount = null,
    Object? gstRate = null,
    Object? totalAmount = null,
    Object? paymentMethod = null,
    Object? downPayment = null,
    Object? loanId = freezed,
    Object? status = null,
    Object? createdAt = null,
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
      carDetails: null == carDetails
          ? _value.carDetails
          : carDetails // ignore: cast_nullable_to_non_nullable
              as CarSnapshot,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      addOns: null == addOns
          ? _value.addOns
          : addOns // ignore: cast_nullable_to_non_nullable
              as List<AddOnModel>,
      discountType: null == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as DiscountType,
      discountValue: null == discountValue
          ? _value.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as double,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      gstAmount: null == gstAmount
          ? _value.gstAmount
          : gstAmount // ignore: cast_nullable_to_non_nullable
              as double,
      gstRate: null == gstRate
          ? _value.gstRate
          : gstRate // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      downPayment: null == downPayment
          ? _value.downPayment
          : downPayment // ignore: cast_nullable_to_non_nullable
              as double,
      loanId: freezed == loanId
          ? _value.loanId
          : loanId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of PurchaseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CarSnapshotCopyWith<$Res> get carDetails {
    return $CarSnapshotCopyWith<$Res>(_value.carDetails, (value) {
      return _then(_value.copyWith(carDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PurchaseModelImplCopyWith<$Res>
    implements $PurchaseModelCopyWith<$Res> {
  factory _$$PurchaseModelImplCopyWith(
          _$PurchaseModelImpl value, $Res Function(_$PurchaseModelImpl) then) =
      __$$PurchaseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String customerId,
      String customerName,
      CarSnapshot carDetails,
      String employeeId,
      String employeeName,
      List<AddOnModel> addOns,
      DiscountType discountType,
      double discountValue,
      double subtotal,
      double gstAmount,
      double gstRate,
      double totalAmount,
      PaymentMethod paymentMethod,
      double downPayment,
      String? loanId,
      PurchaseStatus status,
      DateTime createdAt});

  @override
  $CarSnapshotCopyWith<$Res> get carDetails;
}

/// @nodoc
class __$$PurchaseModelImplCopyWithImpl<$Res>
    extends _$PurchaseModelCopyWithImpl<$Res, _$PurchaseModelImpl>
    implements _$$PurchaseModelImplCopyWith<$Res> {
  __$$PurchaseModelImplCopyWithImpl(
      _$PurchaseModelImpl _value, $Res Function(_$PurchaseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? carDetails = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? addOns = null,
    Object? discountType = null,
    Object? discountValue = null,
    Object? subtotal = null,
    Object? gstAmount = null,
    Object? gstRate = null,
    Object? totalAmount = null,
    Object? paymentMethod = null,
    Object? downPayment = null,
    Object? loanId = freezed,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(_$PurchaseModelImpl(
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
      carDetails: null == carDetails
          ? _value.carDetails
          : carDetails // ignore: cast_nullable_to_non_nullable
              as CarSnapshot,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      addOns: null == addOns
          ? _value._addOns
          : addOns // ignore: cast_nullable_to_non_nullable
              as List<AddOnModel>,
      discountType: null == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as DiscountType,
      discountValue: null == discountValue
          ? _value.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as double,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      gstAmount: null == gstAmount
          ? _value.gstAmount
          : gstAmount // ignore: cast_nullable_to_non_nullable
              as double,
      gstRate: null == gstRate
          ? _value.gstRate
          : gstRate // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      downPayment: null == downPayment
          ? _value.downPayment
          : downPayment // ignore: cast_nullable_to_non_nullable
              as double,
      loanId: freezed == loanId
          ? _value.loanId
          : loanId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseModelImpl extends _PurchaseModel {
  const _$PurchaseModelImpl(
      {required this.id,
      required this.customerId,
      required this.customerName,
      required this.carDetails,
      required this.employeeId,
      required this.employeeName,
      final List<AddOnModel> addOns = const [],
      this.discountType = DiscountType.flat,
      this.discountValue = 0,
      required this.subtotal,
      required this.gstAmount,
      this.gstRate = 0.28,
      required this.totalAmount,
      this.paymentMethod = PaymentMethod.fullPayment,
      this.downPayment = 0,
      this.loanId,
      this.status = PurchaseStatus.completed,
      required this.createdAt})
      : _addOns = addOns,
        super._();

  factory _$PurchaseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String customerId;
  @override
  final String customerName;
  @override
  final CarSnapshot carDetails;
  @override
  final String employeeId;
  @override
  final String employeeName;
  final List<AddOnModel> _addOns;
  @override
  @JsonKey()
  List<AddOnModel> get addOns {
    if (_addOns is EqualUnmodifiableListView) return _addOns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addOns);
  }

  @override
  @JsonKey()
  final DiscountType discountType;
  @override
  @JsonKey()
  final double discountValue;
  @override
  final double subtotal;
  @override
  final double gstAmount;
  @override
  @JsonKey()
  final double gstRate;
  @override
  final double totalAmount;
  @override
  @JsonKey()
  final PaymentMethod paymentMethod;
  @override
  @JsonKey()
  final double downPayment;
  @override
  final String? loanId;
  @override
  @JsonKey()
  final PurchaseStatus status;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'PurchaseModel(id: $id, customerId: $customerId, customerName: $customerName, carDetails: $carDetails, employeeId: $employeeId, employeeName: $employeeName, addOns: $addOns, discountType: $discountType, discountValue: $discountValue, subtotal: $subtotal, gstAmount: $gstAmount, gstRate: $gstRate, totalAmount: $totalAmount, paymentMethod: $paymentMethod, downPayment: $downPayment, loanId: $loanId, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.carDetails, carDetails) ||
                other.carDetails == carDetails) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            const DeepCollectionEquality().equals(other._addOns, _addOns) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.gstAmount, gstAmount) ||
                other.gstAmount == gstAmount) &&
            (identical(other.gstRate, gstRate) || other.gstRate == gstRate) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.downPayment, downPayment) ||
                other.downPayment == downPayment) &&
            (identical(other.loanId, loanId) || other.loanId == loanId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      customerId,
      customerName,
      carDetails,
      employeeId,
      employeeName,
      const DeepCollectionEquality().hash(_addOns),
      discountType,
      discountValue,
      subtotal,
      gstAmount,
      gstRate,
      totalAmount,
      paymentMethod,
      downPayment,
      loanId,
      status,
      createdAt);

  /// Create a copy of PurchaseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseModelImplCopyWith<_$PurchaseModelImpl> get copyWith =>
      __$$PurchaseModelImplCopyWithImpl<_$PurchaseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseModelImplToJson(
      this,
    );
  }
}

abstract class _PurchaseModel extends PurchaseModel {
  const factory _PurchaseModel(
      {required final String id,
      required final String customerId,
      required final String customerName,
      required final CarSnapshot carDetails,
      required final String employeeId,
      required final String employeeName,
      final List<AddOnModel> addOns,
      final DiscountType discountType,
      final double discountValue,
      required final double subtotal,
      required final double gstAmount,
      final double gstRate,
      required final double totalAmount,
      final PaymentMethod paymentMethod,
      final double downPayment,
      final String? loanId,
      final PurchaseStatus status,
      required final DateTime createdAt}) = _$PurchaseModelImpl;
  const _PurchaseModel._() : super._();

  factory _PurchaseModel.fromJson(Map<String, dynamic> json) =
      _$PurchaseModelImpl.fromJson;

  @override
  String get id;
  @override
  String get customerId;
  @override
  String get customerName;
  @override
  CarSnapshot get carDetails;
  @override
  String get employeeId;
  @override
  String get employeeName;
  @override
  List<AddOnModel> get addOns;
  @override
  DiscountType get discountType;
  @override
  double get discountValue;
  @override
  double get subtotal;
  @override
  double get gstAmount;
  @override
  double get gstRate;
  @override
  double get totalAmount;
  @override
  PaymentMethod get paymentMethod;
  @override
  double get downPayment;
  @override
  String? get loanId;
  @override
  PurchaseStatus get status;
  @override
  DateTime get createdAt;

  /// Create a copy of PurchaseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseModelImplCopyWith<_$PurchaseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
