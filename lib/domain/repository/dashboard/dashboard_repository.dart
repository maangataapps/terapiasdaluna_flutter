import 'dart:async';

import 'package:terapiasdaluna/data/repository/events_repository_impl.dart';
import 'package:terapiasdaluna/presentation/dashboard/model/reminder.dart';

abstract class DashboardRepository extends EventsRepositoryImpl {
  Future<List<Reminder>> getReminders(String userId);
}