import 'dart:async';

import 'package:terapiasdaluna/data/repository/events_repository_impl.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';

abstract class SupplementsRepository extends EventsRepositoryImpl {
  Future<void> saveSupplement(Supplement supplement, Function onFinish);
  Future<void> listenToSupplements(String userId, StreamSink<List<Supplement>> streamSink);
  Future<void> editSupplement(Supplement supplement, Function onFinish);
  Future<void> saveSupplementEvent(SupplementEvent supplementEvent, Function onFinish);
  Future<void> listenToSupplementEvents(String userId, StreamSink<List<SupplementEvent>> streamSink);
  Future<void> editSupplementEvent(SupplementEvent supplementEvent, Function onFinish);
  Future<void> deleteSupplementEvent(SupplementEvent supplementEvent);
}