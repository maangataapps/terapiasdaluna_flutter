import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/poopevents/listen_to_poop_events_interactor.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/repository/poopevents/poop_events_repository.dart';

class ListenToPoopEventsInteractorImpl extends ListenToPoopEventsInteractor {
  final PoopEventsRepository poopEventsRepository;

  ListenToPoopEventsInteractorImpl({required this.poopEventsRepository});

  @override
  Future<void> execute(String userId, StreamSink<List<PoopEvent>> streamSink) => poopEventsRepository.listenToPoopEvents(userId, streamSink);

}