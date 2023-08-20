import 'dart:async';

import 'package:terapiasdaluna/presentation/dashboard/model/reminder.dart';

abstract class GetRemindersInteractor {
  Future<List<Reminder>> execute(String userId);
}