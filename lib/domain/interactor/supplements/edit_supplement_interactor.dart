import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';

abstract class EditSupplementInteractor {
  Future<void> execute(Supplement supplement, Function onFinish);
}