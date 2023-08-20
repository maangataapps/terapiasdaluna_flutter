import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';

abstract class EditSupplementEventInteractor {
  Future<void> execute(SupplementEvent supplementEvent, Function onFinish);
}