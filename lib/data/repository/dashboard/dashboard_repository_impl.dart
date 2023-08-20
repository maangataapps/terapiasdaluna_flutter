import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/domain/repository/dashboard/dashboard_repository.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/events_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;
import 'package:terapiasdaluna/presentation/dashboard/model/reminder.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final FirebaseDatabase firebaseDatabase;
  List<SupplementEvent> supplementEvents = [];
  final EventsHelper _eventsHelper = EventsHelper();

  DashboardRepositoryImpl({required this.firebaseDatabase});

  @override
  Future<List<Reminder>> getReminders(String userId) async {
    List<Reminder> allReminders = [];
    final dateTimeHelper = DateTimeHelper();

    final supplementsRef = firebaseDatabase.ref('${constants.supplements}/$userId');
    DataSnapshot querySupplements = await supplementsRef.get().then((value) => value);
    final supplementList = querySupplements.children.map((snapshot) => _eventsHelper.createSupplementFromDatabaseEvent(snapshot)).toList();
    
    var supplementEventsRef = firebaseDatabase.ref('${constants.supplementEvents}/$userId');
    var query = await supplementEventsRef.get();

    for (var supplement in supplementList) {
      var eventDates = query.children
          .map((snapshot) => (snapshot.child(constants.intakeTime).value as int, snapshot.child(constants.supplementId).value as String))
          .where((dateSupplementId) =>
        dateTimeHelper.setDateFromMilliseconds(dateSupplementId.$1).isAfter(dateTimeHelper.getDateAtMidnight(dateSupplementId.$1))
            && supplement.id == dateSupplementId.$2,)
          .map((tuple) => tuple.$1)
          .toList();

      final supplementReminders = _eventsHelper.getRemindersFromSupplement(supplement, eventDates);
      for (var reminder in supplementReminders) {
        if (!allReminders
            .map((thisReminder) => (thisReminder.supplementEvent.timeOfSupplement, thisReminder.supplementEvent.supplementId))
            .contains((reminder.supplementEvent.timeOfSupplement, reminder.supplementEvent.supplementId))) {
          if (supplement.isActivated) allReminders.add(reminder);
        } else {
          if (!supplement.isActivated) {
            allReminders.removeWhere((thisReminder) => (thisReminder.supplementEvent.timeOfSupplement, thisReminder.supplementEvent.supplementId) == (reminder.supplementEvent.timeOfSupplement, reminder.supplementEvent.supplementId));
          }
        }
      }
    }

    return allReminders;
  }

}