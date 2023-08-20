import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileModel {
  String userId;
  String name;
  int userType;
  int birthDate;
  int height;
  int weight;
  int sex;

  ProfileModel({
    required this.userId,
    required this.name,
    required this.userType,
    required this.birthDate,
    required this.height,
    required this.weight,
    required this.sex,
  });

  ProfileModel.empty({
    this.userId = '',
    this.name = '',
    this.userType = 2,
    this.birthDate = -1,
    this.height = -1,
    this.weight = -1,
    this.sex = -1,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

enum UserType {
  admin, premium, user
}

enum SexType {
  male, female
}