// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supplement _$SupplementFromJson(Map<String, dynamic> json) => Supplement(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      name: json['name'] as String,
      dose: Dose.fromJson(json['dose'] as Map<String, dynamic>),
      intakeForm: json['intakeForm'] as int,
      quantityPerBox: json['quantityPerBox'] as int,
      quantityPerTake: json['quantityPerTake'] as int,
      intakesTimes:
          IntakesTimes.fromJson(json['intakesTimes'] as Map<String, dynamic>),
      isActivated: json['isActivated'] as bool,
      outOfMeals: json['outOfMeals'] as bool,
    );

Map<String, dynamic> _$SupplementToJson(Supplement instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'name': instance.name,
      'dose': instance.dose.toJson(),
      'intakeForm': instance.intakeForm,
      'quantityPerBox': instance.quantityPerBox,
      'quantityPerTake': instance.quantityPerTake,
      'intakesTimes': instance.intakesTimes.toJson(),
      'isActivated': instance.isActivated,
      'outOfMeals': instance.outOfMeals,
    };

Dose _$DoseFromJson(Map<String, dynamic> json) => Dose(
      dose: json['dose'] as int,
      unit: $enumDecode(_$UnitEnumMap, json['unit']),
    );

Map<String, dynamic> _$DoseToJson(Dose instance) => <String, dynamic>{
      'dose': instance.dose,
      'unit': _$UnitEnumMap[instance.unit]!,
    };

const _$UnitEnumMap = {
  Unit.ml: 'ml',
  Unit.mg: 'mg',
  Unit.microg: 'microg',
  Unit.UI: 'UI',
  Unit.g: 'g',
  Unit.mgml: 'mgml',
};

IntakesTimes _$IntakesTimesFromJson(Map<String, dynamic> json) => IntakesTimes(
      morning: IntakeTime.fromJson(json['morning'] as Map<String, dynamic>),
      lunch: IntakeTime.fromJson(json['lunch'] as Map<String, dynamic>),
      dinner: IntakeTime.fromJson(json['dinner'] as Map<String, dynamic>),
      night: IntakeTime.fromJson(json['night'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IntakesTimesToJson(IntakesTimes instance) =>
    <String, dynamic>{
      'morning': instance.morning.toJson(),
      'lunch': instance.lunch.toJson(),
      'dinner': instance.dinner.toJson(),
      'night': instance.night.toJson(),
    };

IntakeTime _$IntakeTimeFromJson(Map<String, dynamic> json) => IntakeTime(
      isTakingIt: json['isTakingIt'] as bool,
      exactTime: json['exactTime'] as String?,
    );

Map<String, dynamic> _$IntakeTimeToJson(IntakeTime instance) =>
    <String, dynamic>{
      'isTakingIt': instance.isTakingIt,
      'exactTime': instance.exactTime,
    };
