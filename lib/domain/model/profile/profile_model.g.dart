// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      userId: json['userId'] as String,
      name: json['name'] as String,
      userType: json['userType'] as int,
      birthDate: json['birthDate'] as int,
      height: json['height'] as int,
      weight: json['weight'] as int,
      sex: json['sex'] as int,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'userType': instance.userType,
      'birthDate': instance.birthDate,
      'height': instance.height,
      'weight': instance.weight,
      'sex': instance.sex,
    };
