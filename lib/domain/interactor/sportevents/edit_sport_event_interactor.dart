import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';

abstract class EditSportEventInteractor {
  void execute(SportEvent sportEvent, Function onFinish);
}