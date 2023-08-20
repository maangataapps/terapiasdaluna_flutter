import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/sportevents/listen_to_sport_events_interactor.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/repository/sportevents/sport_events_repository.dart';

class ListenToSportEventsInteractorImpl extends ListenToSportEventsInteractor {
  final SportEventsRepository sportEventsRepository;

  ListenToSportEventsInteractorImpl({required this.sportEventsRepository});

  @override
  Future<void> execute(String userId, StreamSink<List<SportEvent>> streamSink) => sportEventsRepository.listenToSportEvents(userId, streamSink);

}