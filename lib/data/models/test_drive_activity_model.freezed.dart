// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_drive_activity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestDriveActivityModel _$TestDriveActivityModelFromJson(
    Map<String, dynamic> json) {
  return _TestDriveActivityModel.fromJson(json);
}

/// @nodoc
mixin _$TestDriveActivityModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  TestDriveActivityType get type => throw _privateConstructorUsedError;

  /// Serializes this TestDriveActivityModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestDriveActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestDriveActivityModelCopyWith<TestDriveActivityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestDriveActivityModelCopyWith<$Res> {
  factory $TestDriveActivityModelCopyWith(TestDriveActivityModel value,
          $Res Function(TestDriveActivityModel) then) =
      _$TestDriveActivityModelCopyWithImpl<$Res, TestDriveActivityModel>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      String description,
      TestDriveActivityType type});
}

/// @nodoc
class _$TestDriveActivityModelCopyWithImpl<$Res,
        $Val extends TestDriveActivityModel>
    implements $TestDriveActivityModelCopyWith<$Res> {
  _$TestDriveActivityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestDriveActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? description = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TestDriveActivityType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestDriveActivityModelImplCopyWith<$Res>
    implements $TestDriveActivityModelCopyWith<$Res> {
  factory _$$TestDriveActivityModelImplCopyWith(
          _$TestDriveActivityModelImpl value,
          $Res Function(_$TestDriveActivityModelImpl) then) =
      __$$TestDriveActivityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      String description,
      TestDriveActivityType type});
}

/// @nodoc
class __$$TestDriveActivityModelImplCopyWithImpl<$Res>
    extends _$TestDriveActivityModelCopyWithImpl<$Res,
        _$TestDriveActivityModelImpl>
    implements _$$TestDriveActivityModelImplCopyWith<$Res> {
  __$$TestDriveActivityModelImplCopyWithImpl(
      _$TestDriveActivityModelImpl _value,
      $Res Function(_$TestDriveActivityModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestDriveActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? description = null,
    Object? type = null,
  }) {
    return _then(_$TestDriveActivityModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TestDriveActivityType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestDriveActivityModelImpl implements _TestDriveActivityModel {
  const _$TestDriveActivityModelImpl(
      {required this.id,
      required this.timestamp,
      required this.description,
      required this.type});

  factory _$TestDriveActivityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestDriveActivityModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final String description;
  @override
  final TestDriveActivityType type;

  @override
  String toString() {
    return 'TestDriveActivityModel(id: $id, timestamp: $timestamp, description: $description, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDriveActivityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, timestamp, description, type);

  /// Create a copy of TestDriveActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestDriveActivityModelImplCopyWith<_$TestDriveActivityModelImpl>
      get copyWith => __$$TestDriveActivityModelImplCopyWithImpl<
          _$TestDriveActivityModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestDriveActivityModelImplToJson(
      this,
    );
  }
}

abstract class _TestDriveActivityModel implements TestDriveActivityModel {
  const factory _TestDriveActivityModel(
          {required final String id,
          required final DateTime timestamp,
          required final String description,
          required final TestDriveActivityType type}) =
      _$TestDriveActivityModelImpl;

  factory _TestDriveActivityModel.fromJson(Map<String, dynamic> json) =
      _$TestDriveActivityModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  String get description;
  @override
  TestDriveActivityType get type;

  /// Create a copy of TestDriveActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestDriveActivityModelImplCopyWith<_$TestDriveActivityModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
