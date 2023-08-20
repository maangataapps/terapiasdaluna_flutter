import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/supplements/listen_to_supplement_events_interactor.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/domain/repository/supplements/supplements_repository.dart';

class ListenToSupplementEventsInteractorImpl extends ListenToSupplementEventsInteractor {
  final SupplementsRepository supplementsRepository;

  ListenToSupplementEventsInteractorImpl({required this.supplementsRepository});

  @override
  Future<void> execute(String userId, StreamSink<List<SupplementEvent>> streamSink) => supplementsRepository.listenToSupplementEvents(userId, streamSink);

}