import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';

class Reminder {
  final SupplementEvent supplementEvent;
  bool hasBeenTaken;

  Reminder({
    required this.supplementEvent,
    required this.hasBeenTaken,
  });
}