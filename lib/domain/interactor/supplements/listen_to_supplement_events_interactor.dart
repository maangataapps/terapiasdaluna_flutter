import 'dart:async';

import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';

abstract class ListenToSupplementEventsInteractor {
  Future<void> execute(String userId, StreamSink<List<SupplementEvent>> streamSink);
}