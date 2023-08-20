import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';

abstract class SaveSportEventInteractor {
  void execute(SportEvent sportEvent, Function onFinish);
}