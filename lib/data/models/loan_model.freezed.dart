// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoanModel _$LoanModelFromJson(Map<String, dynamic> json) {
  return _LoanModel.fromJson(json);
}

/// @nodoc
mixin _$LoanModel {
  String get id => throw _privateConstructorUsedError;
  String get purchaseId => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  double get principalAmount => throw _privateConstructorUsedError;
  double get interestRate => throw _privateConstructorUsedError;
  int get termMonths => throw _privateConstructorUsedError;
  double get processingFee => throw _privateConstructorUsedError;
  double get emiAmount => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  List<RepaymentEntryModel> get repaymentSchedule =>
      throw _privateConstructorUsedError;
  LoanStatus get status => throw _privateConstructorUsedError;
  String get guarantorName => throw _privateConstructorUsedError;
  String get guarantorPhone => throw _privateConstructorUsedError;
  String get guarantorRelationship => throw _privateConstructorUsedError;

  /// Serializes this LoanModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoanModelCopyWith<LoanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoanModelCopyWith<$Res> {
  factory $LoanModelCopyWith(LoanModel value, $Res Function(LoanModel) then) =
      _$LoanModelCopyWithImpl<$Res, LoanModel>;
  @useResult
  $Res call(
      {String id,
      String purchaseId,
      String customerId,
      double principalAmount,
      double interestRate,
      int termMonths,
      double processingFee,
      double emiAmount,
      DateTime startDate,
      List<RepaymentEntryModel> repaymentSchedule,
      LoanStatus status,
      String guarantorName,
      String guarantorPhone,
      String guarantorRelationship});
}

/// @nodoc
class _$LoanModelCopyWithImpl<$Res, $Val extends LoanModel>
    implements $LoanModelCopyWith<$Res> {
  _$LoanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? purchaseId = null,
    Object? customerId = null,
    Object? principalAmount = null,
    Object? interestRate = null,
    Object? termMonths = null,
    Object? processingFee = null,
    Object? emiAmount = null,
    Object? startDate = null,
    Object? repaymentSchedule = null,
    Object? status = null,
    Object? guarantorName = null,
    Object? guarantorPhone = null,
    Object? guarantorRelationship = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseId: null == purchaseId
          ? _value.purchaseId
          : purchaseId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      principalAmount: null == principalAmount
          ? _value.principalAmount
          : principalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      interestRate: null == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double,
      termMonths: null == termMonths
          ? _value.termMonths
          : termMonths // ignore: cast_nullable_to_non_nullable
              as int,
      processingFee: null == processingFee
          ? _value.processingFee
          : processingFee // ignore: cast_nullable_to_non_nullable
              as double,
      emiAmount: null == emiAmount
          ? _value.emiAmount
          : emiAmount // ignore: cast_nullable_to_non_nullable
              as double,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      repaymentSchedule: null == repaymentSchedule
          ? _value.repaymentSchedule
          : repaymentSchedule // ignore: cast_nullable_to_non_nullable
              as List<RepaymentEntryModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoanStatus,
      guarantorName: null == guarantorName
          ? _value.guarantorName
          : guarantorName // ignore: cast_nullable_to_non_nullable
              as String,
      guarantorPhone: null == guarantorPhone
          ? _value.guarantorPhone
          : guarantorPhone // ignore: cast_nullable_to_non_nullable
              as String,
      guarantorRelationship: null == guarantorRelationship
          ? _value.guarantorRelationship
          : guarantorRelationship // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoanModelImplCopyWith<$Res>
    implements $LoanModelCopyWith<$Res> {
  factory _$$LoanModelImplCopyWith(
          _$LoanModelImpl value, $Res Function(_$LoanModelImpl) then) =
      __$$LoanModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String purchaseId,
      String customerId,
      double principalAmount,
      double interestRate,
      int termMonths,
      double processingFee,
      double emiAmount,
      DateTime startDate,
      List<RepaymentEntryModel> repaymentSchedule,
      LoanStatus status,
      String guarantorName,
      String guarantorPhone,
      String guarantorRelationship});
}

/// @nodoc
class __$$LoanModelImplCopyWithImpl<$Res>
    extends _$LoanModelCopyWithImpl<$Res, _$LoanModelImpl>
    implements _$$LoanModelImplCopyWith<$Res> {
  __$$LoanModelImplCopyWithImpl(
      _$LoanModelImpl _value, $Res Function(_$LoanModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? purchaseId = null,
    Object? customerId = null,
    Object? principalAmount = null,
    Object? interestRate = null,
    Object? termMonths = null,
    Object? processingFee = null,
    Object? emiAmount = null,
    Object? startDate = null,
    Object? repaymentSchedule = null,
    Object? status = null,
    Object? guarantorName = null,
    Object? guarantorPhone = null,
    Object? guarantorRelationship = null,
  }) {
    return _then(_$LoanModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseId: null == purchaseId
          ? _value.purchaseId
          : purchaseId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      principalAmount: null == principalAmount
          ? _value.principalAmount
          : principalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      interestRate: null == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double,
      termMonths: null == termMonths
          ? _value.termMonths
          : termMonths // ignore: cast_nullable_to_non_nullable
              as int,
      processingFee: null == processingFee
          ? _value.processingFee
          : processingFee // ignore: cast_nullable_to_non_nullable
              as double,
      emiAmount: null == emiAmount
          ? _value.emiAmount
          : emiAmount // ignore: cast_nullable_to_non_nullable
              as double,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      repaymentSchedule: null == repaymentSchedule
          ? _value._repaymentSchedule
          : repaymentSchedule // ignore: cast_nullable_to_non_nullable
              as List<RepaymentEntryModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoanStatus,
      guarantorName: null == guarantorName
          ? _value.guarantorName
          : guarantorName // ignore: cast_nullable_to_non_nullable
              as String,
      guarantorPhone: null == guarantorPhone
          ? _value.guarantorPhone
          : guarantorPhone // ignore: cast_nullable_to_non_nullable
              as String,
      guarantorRelationship: null == guarantorRelationship
          ? _value.guarantorRelationship
          : guarantorRelationship // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoanModelImpl extends _LoanModel {
  const _$LoanModelImpl(
      {required this.id,
      required this.purchaseId,
      required this.customerId,
      required this.principalAmount,
      required this.interestRate,
      required this.termMonths,
      this.processingFee = 5000,
      required this.emiAmount,
      required this.startDate,
      final List<RepaymentEntryModel> repaymentSchedule = const [],
      this.status = LoanStatus.active,
      this.guarantorName = '',
      this.guarantorPhone = '',
      this.guarantorRelationship = ''})
      : _repaymentSchedule = repaymentSchedule,
        super._();

  factory _$LoanModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoanModelImplFromJson(json);

  @override
  final String id;
  @override
  final String purchaseId;
  @override
  final String customerId;
  @override
  final double principalAmount;
  @override
  final double interestRate;
  @override
  final int termMonths;
  @override
  @JsonKey()
  final double processingFee;
  @override
  final double emiAmount;
  @override
  final DateTime startDate;
  final List<RepaymentEntryModel> _repaymentSchedule;
  @override
  @JsonKey()
  List<RepaymentEntryModel> get repaymentSchedule {
    if (_repaymentSchedule is EqualUnmodifiableListView)
      return _repaymentSchedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_repaymentSchedule);
  }

  @override
  @JsonKey()
  final LoanStatus status;
  @override
  @JsonKey()
  final String guarantorName;
  @override
  @JsonKey()
  final String guarantorPhone;
  @override
  @JsonKey()
  final String guarantorRelationship;

  @override
  String toString() {
    return 'LoanModel(id: $id, purchaseId: $purchaseId, customerId: $customerId, principalAmount: $principalAmount, interestRate: $interestRate, termMonths: $termMonths, processingFee: $processingFee, emiAmount: $emiAmount, startDate: $startDate, repaymentSchedule: $repaymentSchedule, status: $status, guarantorName: $guarantorName, guarantorPhone: $guarantorPhone, guarantorRelationship: $guarantorRelationship)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoanModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.purchaseId, purchaseId) ||
                other.purchaseId == purchaseId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.principalAmount, principalAmount) ||
                other.principalAmount == principalAmount) &&
            (identical(other.interestRate, interestRate) ||
                other.interestRate == interestRate) &&
            (identical(other.termMonths, termMonths) ||
                other.termMonths == termMonths) &&
            (identical(other.processingFee, processingFee) ||
                other.processingFee == processingFee) &&
            (identical(other.emiAmount, emiAmount) ||
                other.emiAmount == emiAmount) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            const DeepCollectionEquality()
                .equals(other._repaymentSchedule, _repaymentSchedule) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.guarantorName, guarantorName) ||
                other.guarantorName == guarantorName) &&
            (identical(other.guarantorPhone, guarantorPhone) ||
                other.guarantorPhone == guarantorPhone) &&
            (identical(other.guarantorRelationship, guarantorRelationship) ||
                other.guarantorRelationship == guarantorRelationship));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      purchaseId,
      customerId,
      principalAmount,
      interestRate,
      termMonths,
      processingFee,
      emiAmount,
      startDate,
      const DeepCollectionEquality().hash(_repaymentSchedule),
      status,
      guarantorName,
      guarantorPhone,
      guarantorRelationship);

  /// Create a copy of LoanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoanModelImplCopyWith<_$LoanModelImpl> get copyWith =>
      __$$LoanModelImplCopyWithImpl<_$LoanModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoanModelImplToJson(
      this,
    );
  }
}

abstract class _LoanModel extends LoanModel {
  const factory _LoanModel(
      {required final String id,
      required final String purchaseId,
      required final String customerId,
      required final double principalAmount,
      required final double interestRate,
      required final int termMonths,
      final double processingFee,
      required final double emiAmount,
      required final DateTime startDate,
      final List<RepaymentEntryModel> repaymentSchedule,
      final LoanStatus status,
      final String guarantorName,
      final String guarantorPhone,
      final String guarantorRelationship}) = _$LoanModelImpl;
  const _LoanModel._() : super._();

  factory _LoanModel.fromJson(Map<String, dynamic> json) =
      _$LoanModelImpl.fromJson;

  @override
  String get id;
  @override
  String get purchaseId;
  @override
  String get customerId;
  @override
  double get principalAmount;
  @override
  double get interestRate;
  @override
  int get termMonths;
  @override
  double get processingFee;
  @override
  double get emiAmount;
  @override
  DateTime get startDate;
  @override
  List<RepaymentEntryModel> get repaymentSchedule;
  @override
  LoanStatus get status;
  @override
  String get guarantorName;
  @override
  String get guarantorPhone;
  @override
  String get guarantorRelationship;

  /// Create a copy of LoanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoanModelImplCopyWith<_$LoanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
