import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/sleepevents/listen_to_sleep_events_interactor.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/repository/sleepevents/sleep_events_repository.dart';

class ListenToSleepEventsInteractorImpl extends ListenToSleepEventsInteractor {
  final SleepEventsRepository sleepEventsRepository;

  ListenToSleepEventsInteractorImpl({required this.sleepEventsRepository});

  @override
  Future<void> execute(String userId, StreamSink<List<SleepEvent>> streamSink) => sleepEventsRepository.listenToSleepEvents(userId, streamSink);

}