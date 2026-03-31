// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repayment_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RepaymentEntryModel _$RepaymentEntryModelFromJson(Map<String, dynamic> json) {
  return _RepaymentEntryModel.fromJson(json);
}

/// @nodoc
mixin _$RepaymentEntryModel {
  int get month => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  double get emiAmount => throw _privateConstructorUsedError;
  double get principalComponent => throw _privateConstructorUsedError;
  double get interestComponent => throw _privateConstructorUsedError;
  double get remainingBalance => throw _privateConstructorUsedError;
  bool get isPaid => throw _privateConstructorUsedError;

  /// Serializes this RepaymentEntryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepaymentEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepaymentEntryModelCopyWith<RepaymentEntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepaymentEntryModelCopyWith<$Res> {
  factory $RepaymentEntryModelCopyWith(
          RepaymentEntryModel value, $Res Function(RepaymentEntryModel) then) =
      _$RepaymentEntryModelCopyWithImpl<$Res, RepaymentEntryModel>;
  @useResult
  $Res call(
      {int month,
      DateTime dueDate,
      double emiAmount,
      double principalComponent,
      double interestComponent,
      double remainingBalance,
      bool isPaid});
}

/// @nodoc
class _$RepaymentEntryModelCopyWithImpl<$Res, $Val extends RepaymentEntryModel>
    implements $RepaymentEntryModelCopyWith<$Res> {
  _$RepaymentEntryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepaymentEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? dueDate = null,
    Object? emiAmount = null,
    Object? principalComponent = null,
    Object? interestComponent = null,
    Object? remainingBalance = null,
    Object? isPaid = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emiAmount: null == emiAmount
          ? _value.emiAmount
          : emiAmount // ignore: cast_nullable_to_non_nullable
              as double,
      principalComponent: null == principalComponent
          ? _value.principalComponent
          : principalComponent // ignore: cast_nullable_to_non_nullable
              as double,
      interestComponent: null == interestComponent
          ? _value.interestComponent
          : interestComponent // ignore: cast_nullable_to_non_nullable
              as double,
      remainingBalance: null == remainingBalance
          ? _value.remainingBalance
          : remainingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepaymentEntryModelImplCopyWith<$Res>
    implements $RepaymentEntryModelCopyWith<$Res> {
  factory _$$RepaymentEntryModelImplCopyWith(_$RepaymentEntryModelImpl value,
          $Res Function(_$RepaymentEntryModelImpl) then) =
      __$$RepaymentEntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int month,
      DateTime dueDate,
      double emiAmount,
      double principalComponent,
      double interestComponent,
      double remainingBalance,
      bool isPaid});
}

/// @nodoc
class __$$RepaymentEntryModelImplCopyWithImpl<$Res>
    extends _$RepaymentEntryModelCopyWithImpl<$Res, _$RepaymentEntryModelImpl>
    implements _$$RepaymentEntryModelImplCopyWith<$Res> {
  __$$RepaymentEntryModelImplCopyWithImpl(_$RepaymentEntryModelImpl _value,
      $Res Function(_$RepaymentEntryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RepaymentEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? dueDate = null,
    Object? emiAmount = null,
    Object? principalComponent = null,
    Object? interestComponent = null,
    Object? remainingBalance = null,
    Object? isPaid = null,
  }) {
    return _then(_$RepaymentEntryModelImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emiAmount: null == emiAmount
          ? _value.emiAmount
          : emiAmount // ignore: cast_nullable_to_non_nullable
              as double,
      principalComponent: null == principalComponent
          ? _value.principalComponent
          : principalComponent // ignore: cast_nullable_to_non_nullable
              as double,
      interestComponent: null == interestComponent
          ? _value.interestComponent
          : interestComponent // ignore: cast_nullable_to_non_nullable
              as double,
      remainingBalance: null == remainingBalance
          ? _value.remainingBalance
          : remainingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RepaymentEntryModelImpl implements _RepaymentEntryModel {
  const _$RepaymentEntryModelImpl(
      {required this.month,
      required this.dueDate,
      required this.emiAmount,
      required this.principalComponent,
      required this.interestComponent,
      required this.remainingBalance,
      this.isPaid = false});

  factory _$RepaymentEntryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepaymentEntryModelImplFromJson(json);

  @override
  final int month;
  @override
  final DateTime dueDate;
  @override
  final double emiAmount;
  @override
  final double principalComponent;
  @override
  final double interestComponent;
  @override
  final double remainingBalance;
  @override
  @JsonKey()
  final bool isPaid;

  @override
  String toString() {
    return 'RepaymentEntryModel(month: $month, dueDate: $dueDate, emiAmount: $emiAmount, principalComponent: $principalComponent, interestComponent: $interestComponent, remainingBalance: $remainingBalance, isPaid: $isPaid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepaymentEntryModelImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.emiAmount, emiAmount) ||
                other.emiAmount == emiAmount) &&
            (identical(other.principalComponent, principalComponent) ||
                other.principalComponent == principalComponent) &&
            (identical(other.interestComponent, interestComponent) ||
                other.interestComponent == interestComponent) &&
            (identical(other.remainingBalance, remainingBalance) ||
                other.remainingBalance == remainingBalance) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, month, dueDate, emiAmount,
      principalComponent, interestComponent, remainingBalance, isPaid);

  /// Create a copy of RepaymentEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepaymentEntryModelImplCopyWith<_$RepaymentEntryModelImpl> get copyWith =>
      __$$RepaymentEntryModelImplCopyWithImpl<_$RepaymentEntryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepaymentEntryModelImplToJson(
      this,
    );
  }
}

abstract class _RepaymentEntryModel implements RepaymentEntryModel {
  const factory _RepaymentEntryModel(
      {required final int month,
      required final DateTime dueDate,
      required final double emiAmount,
      required final double principalComponent,
      required final double interestComponent,
      required final double remainingBalance,
      final bool isPaid}) = _$RepaymentEntryModelImpl;

  factory _RepaymentEntryModel.fromJson(Map<String, dynamic> json) =
      _$RepaymentEntryModelImpl.fromJson;

  @override
  int get month;
  @override
  DateTime get dueDate;
  @override
  double get emiAmount;
  @override
  double get principalComponent;
  @override
  double get interestComponent;
  @override
  double get remainingBalance;
  @override
  bool get isPaid;

  /// Create a copy of RepaymentEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepaymentEntryModelImplCopyWith<_$RepaymentEntryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
