import 'package:terapiasdaluna/domain/interactor/supplements/save_supplement_interactor.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/repository/supplements/supplements_repository.dart';

class SaveSupplementInteractorImpl extends SaveSupplementInteractor {
  final SupplementsRepository supplementsRepository;

  SaveSupplementInteractorImpl({required this.supplementsRepository});

  @override
  Future<void> execute(Supplement supplement, Function onFinish) async => await supplementsRepository.saveSupplement(supplement, onFinish);

}