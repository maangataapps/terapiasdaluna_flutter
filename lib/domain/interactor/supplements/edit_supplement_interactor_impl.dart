import 'package:terapiasdaluna/domain/interactor/supplements/edit_supplement_interactor.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/repository/supplements/supplements_repository.dart';

class EditSupplementInteractorImpl extends EditSupplementInteractor {
  final SupplementsRepository supplementsRepository;

  EditSupplementInteractorImpl({required this.supplementsRepository});

  @override
  Future<void> execute(Supplement supplement, Function onFinish) async => await supplementsRepository.editSupplement(supplement, onFinish);

}