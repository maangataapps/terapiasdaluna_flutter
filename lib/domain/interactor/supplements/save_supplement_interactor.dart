import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';

abstract class SaveSupplementInteractor {
  Future<void> execute(Supplement supplement, Function onFinish);
}