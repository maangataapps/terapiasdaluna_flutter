import 'package:terapiasdaluna/domain/interactor/supplements/delete_supplement_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/domain/repository/supplements/supplements_repository.dart';

class DeleteSupplementEventInteractorImpl extends DeleteSupplementEventInteractor {
  final SupplementsRepository supplementsRepository;

  DeleteSupplementEventInteractorImpl({required this.supplementsRepository});

  @override
  Future<void> execute(SupplementEvent supplementEvent) async => await supplementsRepository.deleteSupplementEvent(supplementEvent);

}