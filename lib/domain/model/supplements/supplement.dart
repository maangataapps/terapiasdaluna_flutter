import 'package:json_annotation/json_annotation.dart';

part 'supplement.g.dart';

@JsonSerializable(explicitToJson: true)
class Supplement {
  String? userId;
  final String id;
  final String name;
  final Dose dose;
  final int intakeForm;
  final int quantityPerBox;
  final int quantityPerTake;
  final IntakesTimes intakesTimes;
  bool isActivated;
  bool outOfMeals;

  Supplement({
    required this.id,
    this.userId,
    required this.name,
    required this.dose,
    required this.intakeForm,
    required this.quantityPerBox,
    required this.quantityPerTake,
    required this.intakesTimes,
    required this.isActivated,
    required this.outOfMeals,
  });

  factory Supplement.fromJson(Map<String, dynamic> json) => _$SupplementFromJson(json);
  Map<String, dynamic> toJson() => _$SupplementToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Dose {
  final int dose;
  final Unit unit;

  Dose({
    required this.dose,
    required this.unit,
  });

  factory Dose.fromJson(Map<String, dynamic> json) => _$DoseFromJson(json);
  Map<String, dynamic> toJson() => _$DoseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class IntakesTimes {
  IntakeTime morning;
  IntakeTime lunch;
  IntakeTime dinner;
  IntakeTime night;

  IntakesTimes({
    required this.morning,
    required this.lunch,
    required this.dinner,
    required this.night,
  });

  factory IntakesTimes.fromJson(Map<String, dynamic> json) => _$IntakesTimesFromJson(json);
  Map<String, dynamic> toJson() => _$IntakesTimesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class IntakeTime {
  bool isTakingIt;
  String? exactTime;

  IntakeTime({
    required this.isTakingIt,
    this.exactTime,
  });

  IntakeTime.empty({
    this.isTakingIt = false,
    this.exactTime,
  });

  factory IntakeTime.fromJson(Map<String, dynamic> json) => _$IntakeTimeFromJson(json);
  Map<String, dynamic> toJson() => _$IntakeTimeToJson(this);
}

enum Unit {
  ml, mg, microg, UI, g, mgml,
}

enum IntakeForm {
  pill, capsule, spoon, vial, drop,
}