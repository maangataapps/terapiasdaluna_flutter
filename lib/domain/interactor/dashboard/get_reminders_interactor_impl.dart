import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/dashboard/get_reminders_interactor.dart';
import 'package:terapiasdaluna/domain/repository/dashboard/dashboard_repository.dart';
import 'package:terapiasdaluna/presentation/dashboard/model/reminder.dart';

class GetRemindersInteractorImpl extends GetRemindersInteractor {
  final DashboardRepository dashboardRepository;

  GetRemindersInteractorImpl({required this.dashboardRepository});

  @override
  Future<List<Reminder>> execute(String userId) async => await dashboardRepository.getReminders(userId);

}