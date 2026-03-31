// data/models/showroom_model.dart
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'showroom_model.freezed.dart';
part 'showroom_model.g.dart';

@freezed
class ShowroomModel with _$ShowroomModel {
  const factory ShowroomModel({
    required String id,
    required String name,
    @Default('') String gstNumber,
    @Default('') String phone,
    @Default('') String email,
    @Default('') String address,
    @Default('') String city,
    @Default('') String state,
    @Default('') String pinCode,
    @Default('') String logoUrl,
    required String ownerId,
    required String showroomCode, // 6-char alphanumeric for employee linking
    required DateTime createdAt,
  }) = _ShowroomModel;

  factory ShowroomModel.fromJson(Map<String, dynamic> json) =>
      _$ShowroomModelFromJson(json);
}

const indianStates = [
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
  'Andaman and Nicobar Islands',
  'Chandigarh',
  'Dadra and Nagar Haveli',
  'Daman and Diu',
  'Delhi',
  'Jammu and Kashmir',
  'Ladakh',
  'Lakshadweep',
  'Puducherry',
];
