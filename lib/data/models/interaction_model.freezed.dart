// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InteractionModel _$InteractionModelFromJson(Map<String, dynamic> json) {
  return _InteractionModel.fromJson(json);
}

/// @nodoc
mixin _$InteractionModel {
  String get id => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  InteractionType get type => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this InteractionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InteractionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InteractionModelCopyWith<InteractionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InteractionModelCopyWith<$Res> {
  factory $InteractionModelCopyWith(
          InteractionModel value, $Res Function(InteractionModel) then) =
      _$InteractionModelCopyWithImpl<$Res, InteractionModel>;
  @useResult
  $Res call(
      {String id,
      String customerId,
      InteractionType type,
      String note,
      DateTime timestamp});
}

/// @nodoc
class _$InteractionModelCopyWithImpl<$Res, $Val extends InteractionModel>
    implements $InteractionModelCopyWith<$Res> {
  _$InteractionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InteractionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? type = null,
    Object? note = null,
    Object? timestamp = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InteractionType,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InteractionModelImplCopyWith<$Res>
    implements $InteractionModelCopyWith<$Res> {
  factory _$$InteractionModelImplCopyWith(_$InteractionModelImpl value,
          $Res Function(_$InteractionModelImpl) then) =
      __$$InteractionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String customerId,
      InteractionType type,
      String note,
      DateTime timestamp});
}

/// @nodoc
class __$$InteractionModelImplCopyWithImpl<$Res>
    extends _$InteractionModelCopyWithImpl<$Res, _$InteractionModelImpl>
    implements _$$InteractionModelImplCopyWith<$Res> {
  __$$InteractionModelImplCopyWithImpl(_$InteractionModelImpl _value,
      $Res Function(_$InteractionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of InteractionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? type = null,
    Object? note = null,
    Object? timestamp = null,
  }) {
    return _then(_$InteractionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InteractionType,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InteractionModelImpl implements _InteractionModel {
  const _$InteractionModelImpl(
      {required this.id,
      required this.customerId,
      required this.type,
      required this.note,
      required this.timestamp});

  factory _$InteractionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InteractionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String customerId;
  @override
  final InteractionType type;
  @override
  final String note;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'InteractionModel(id: $id, customerId: $customerId, type: $type, note: $note, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InteractionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, customerId, type, note, timestamp);

  /// Create a copy of InteractionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InteractionModelImplCopyWith<_$InteractionModelImpl> get copyWith =>
      __$$InteractionModelImplCopyWithImpl<_$InteractionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InteractionModelImplToJson(
      this,
    );
  }
}

abstract class _InteractionModel implements InteractionModel {
  const factory _InteractionModel(
      {required final String id,
      required final String customerId,
      required final InteractionType type,
      required final String note,
      required final DateTime timestamp}) = _$InteractionModelImpl;

  factory _InteractionModel.fromJson(Map<String, dynamic> json) =
      _$InteractionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get customerId;
  @override
  InteractionType get type;
  @override
  String get note;
  @override
  DateTime get timestamp;

  /// Create a copy of InteractionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InteractionModelImplCopyWith<_$InteractionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
