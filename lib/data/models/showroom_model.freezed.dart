// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'showroom_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShowroomModel _$ShowroomModelFromJson(Map<String, dynamic> json) {
  return _ShowroomModel.fromJson(json);
}

/// @nodoc
mixin _$ShowroomModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get gstNumber => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get pinCode => throw _privateConstructorUsedError;
  String get logoUrl => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get showroomCode =>
      throw _privateConstructorUsedError; // 6-char alphanumeric for employee linking
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ShowroomModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShowroomModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShowroomModelCopyWith<ShowroomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowroomModelCopyWith<$Res> {
  factory $ShowroomModelCopyWith(
          ShowroomModel value, $Res Function(ShowroomModel) then) =
      _$ShowroomModelCopyWithImpl<$Res, ShowroomModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String gstNumber,
      String phone,
      String email,
      String address,
      String city,
      String state,
      String pinCode,
      String logoUrl,
      String ownerId,
      String showroomCode,
      DateTime createdAt});
}

/// @nodoc
class _$ShowroomModelCopyWithImpl<$Res, $Val extends ShowroomModel>
    implements $ShowroomModelCopyWith<$Res> {
  _$ShowroomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShowroomModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gstNumber = null,
    Object? phone = null,
    Object? email = null,
    Object? address = null,
    Object? city = null,
    Object? state = null,
    Object? pinCode = null,
    Object? logoUrl = null,
    Object? ownerId = null,
    Object? showroomCode = null,
    Object? createdAt = null,
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
      gstNumber: null == gstNumber
          ? _value.gstNumber
          : gstNumber // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      pinCode: null == pinCode
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: null == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      showroomCode: null == showroomCode
          ? _value.showroomCode
          : showroomCode // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShowroomModelImplCopyWith<$Res>
    implements $ShowroomModelCopyWith<$Res> {
  factory _$$ShowroomModelImplCopyWith(
          _$ShowroomModelImpl value, $Res Function(_$ShowroomModelImpl) then) =
      __$$ShowroomModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String gstNumber,
      String phone,
      String email,
      String address,
      String city,
      String state,
      String pinCode,
      String logoUrl,
      String ownerId,
      String showroomCode,
      DateTime createdAt});
}

/// @nodoc
class __$$ShowroomModelImplCopyWithImpl<$Res>
    extends _$ShowroomModelCopyWithImpl<$Res, _$ShowroomModelImpl>
    implements _$$ShowroomModelImplCopyWith<$Res> {
  __$$ShowroomModelImplCopyWithImpl(
      _$ShowroomModelImpl _value, $Res Function(_$ShowroomModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShowroomModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gstNumber = null,
    Object? phone = null,
    Object? email = null,
    Object? address = null,
    Object? city = null,
    Object? state = null,
    Object? pinCode = null,
    Object? logoUrl = null,
    Object? ownerId = null,
    Object? showroomCode = null,
    Object? createdAt = null,
  }) {
    return _then(_$ShowroomModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gstNumber: null == gstNumber
          ? _value.gstNumber
          : gstNumber // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      pinCode: null == pinCode
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: null == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      showroomCode: null == showroomCode
          ? _value.showroomCode
          : showroomCode // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShowroomModelImpl implements _ShowroomModel {
  const _$ShowroomModelImpl(
      {required this.id,
      required this.name,
      this.gstNumber = '',
      this.phone = '',
      this.email = '',
      this.address = '',
      this.city = '',
      this.state = '',
      this.pinCode = '',
      this.logoUrl = '',
      required this.ownerId,
      required this.showroomCode,
      required this.createdAt});

  factory _$ShowroomModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShowroomModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String gstNumber;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String state;
  @override
  @JsonKey()
  final String pinCode;
  @override
  @JsonKey()
  final String logoUrl;
  @override
  final String ownerId;
  @override
  final String showroomCode;
// 6-char alphanumeric for employee linking
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ShowroomModel(id: $id, name: $name, gstNumber: $gstNumber, phone: $phone, email: $email, address: $address, city: $city, state: $state, pinCode: $pinCode, logoUrl: $logoUrl, ownerId: $ownerId, showroomCode: $showroomCode, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowroomModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gstNumber, gstNumber) ||
                other.gstNumber == gstNumber) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.pinCode, pinCode) || other.pinCode == pinCode) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.showroomCode, showroomCode) ||
                other.showroomCode == showroomCode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      gstNumber,
      phone,
      email,
      address,
      city,
      state,
      pinCode,
      logoUrl,
      ownerId,
      showroomCode,
      createdAt);

  /// Create a copy of ShowroomModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowroomModelImplCopyWith<_$ShowroomModelImpl> get copyWith =>
      __$$ShowroomModelImplCopyWithImpl<_$ShowroomModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShowroomModelImplToJson(
      this,
    );
  }
}

abstract class _ShowroomModel implements ShowroomModel {
  const factory _ShowroomModel(
      {required final String id,
      required final String name,
      final String gstNumber,
      final String phone,
      final String email,
      final String address,
      final String city,
      final String state,
      final String pinCode,
      final String logoUrl,
      required final String ownerId,
      required final String showroomCode,
      required final DateTime createdAt}) = _$ShowroomModelImpl;

  factory _ShowroomModel.fromJson(Map<String, dynamic> json) =
      _$ShowroomModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get gstNumber;
  @override
  String get phone;
  @override
  String get email;
  @override
  String get address;
  @override
  String get city;
  @override
  String get state;
  @override
  String get pinCode;
  @override
  String get logoUrl;
  @override
  String get ownerId;
  @override
  String get showroomCode; // 6-char alphanumeric for employee linking
  @override
  DateTime get createdAt;

  /// Create a copy of ShowroomModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowroomModelImplCopyWith<_$ShowroomModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
