import 'dart:async';

import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';

abstract class ListenToSupplementsInteractor {
  Future<void> execute(String userId, StreamSink<List<Supplement>> streamSink);
}