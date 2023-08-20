import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';

abstract class DeleteSportEventInteractor {
  Future<void> execute(SportEvent sportEvent);
}