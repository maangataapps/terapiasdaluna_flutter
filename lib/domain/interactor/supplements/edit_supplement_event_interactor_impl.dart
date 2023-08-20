import 'package:terapiasdaluna/domain/interactor/supplements/edit_supplement_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/domain/repository/supplements/supplements_repository.dart';

class EditSupplementEventInteractorImpl extends EditSupplementEventInteractor {
  final SupplementsRepository supplementsRepository;

  EditSupplementEventInteractorImpl({required this.supplementsRepository});

  @override
  Future<void> execute(SupplementEvent supplementEvent, Function onFinish) async => await supplementsRepository.editSupplementEvent(supplementEvent, onFinish);

}