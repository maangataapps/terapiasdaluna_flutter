import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';

abstract class SaveSupplementEventInteractor {
  Future<void> execute(SupplementEvent supplementEvent, Function onFinish);
}