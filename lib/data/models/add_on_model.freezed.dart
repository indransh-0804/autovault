// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_on_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddOnModel _$AddOnModelFromJson(Map<String, dynamic> json) {
  return _AddOnModel.fromJson(json);
}

/// @nodoc
mixin _$AddOnModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  bool get isCustom => throw _privateConstructorUsedError;

  /// Serializes this AddOnModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddOnModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddOnModelCopyWith<AddOnModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddOnModelCopyWith<$Res> {
  factory $AddOnModelCopyWith(
          AddOnModel value, $Res Function(AddOnModel) then) =
      _$AddOnModelCopyWithImpl<$Res, AddOnModel>;
  @useResult
  $Res call({String id, String name, double price, bool isCustom});
}

/// @nodoc
class _$AddOnModelCopyWithImpl<$Res, $Val extends AddOnModel>
    implements $AddOnModelCopyWith<$Res> {
  _$AddOnModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddOnModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? isCustom = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddOnModelImplCopyWith<$Res>
    implements $AddOnModelCopyWith<$Res> {
  factory _$$AddOnModelImplCopyWith(
          _$AddOnModelImpl value, $Res Function(_$AddOnModelImpl) then) =
      __$$AddOnModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, double price, bool isCustom});
}

/// @nodoc
class __$$AddOnModelImplCopyWithImpl<$Res>
    extends _$AddOnModelCopyWithImpl<$Res, _$AddOnModelImpl>
    implements _$$AddOnModelImplCopyWith<$Res> {
  __$$AddOnModelImplCopyWithImpl(
      _$AddOnModelImpl _value, $Res Function(_$AddOnModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddOnModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? isCustom = null,
  }) {
    return _then(_$AddOnModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddOnModelImpl implements _AddOnModel {
  const _$AddOnModelImpl(
      {required this.id,
      required this.name,
      required this.price,
      this.isCustom = false});

  factory _$AddOnModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddOnModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double price;
  @override
  @JsonKey()
  final bool isCustom;

  @override
  String toString() {
    return 'AddOnModel(id: $id, name: $name, price: $price, isCustom: $isCustom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddOnModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, price, isCustom);

  /// Create a copy of AddOnModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddOnModelImplCopyWith<_$AddOnModelImpl> get copyWith =>
      __$$AddOnModelImplCopyWithImpl<_$AddOnModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddOnModelImplToJson(
      this,
    );
  }
}

abstract class _AddOnModel implements AddOnModel {
  const factory _AddOnModel(
      {required final String id,
      required final String name,
      required final double price,
      final bool isCustom}) = _$AddOnModelImpl;

  factory _AddOnModel.fromJson(Map<String, dynamic> json) =
      _$AddOnModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get price;
  @override
  bool get isCustom;

  /// Create a copy of AddOnModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddOnModelImplCopyWith<_$AddOnModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
