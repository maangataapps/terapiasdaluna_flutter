import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';

abstract class DeleteSupplementEventInteractor {
  Future<void> execute(SupplementEvent supplementEvent);
}