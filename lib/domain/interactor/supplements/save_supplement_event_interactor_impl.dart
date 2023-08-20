import 'package:terapiasdaluna/domain/interactor/supplements/save_supplement_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/domain/repository/supplements/supplements_repository.dart';

class SaveSupplementEventInteractorImpl extends SaveSupplementEventInteractor {
  final SupplementsRepository supplementsRepository;

  SaveSupplementEventInteractorImpl({required this.supplementsRepository});

  @override
  Future<void> execute(SupplementEvent supplementEvent, Function onFinish) async => await supplementsRepository.saveSupplementEvent(supplementEvent, onFinish);

}