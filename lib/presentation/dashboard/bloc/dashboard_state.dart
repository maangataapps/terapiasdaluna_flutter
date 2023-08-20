import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';
import 'package:terapiasdaluna/presentation/dashboard/model/reminder.dart';

class DashboardState {
  bool isLoading;
  ErrorTypes? onError;
  List<Reminder>? reminders;

  DashboardState({
    required this.isLoading,
    required this.onError,
    required this.reminders,
  });

  DashboardState copyWith({
    required bool isLoading,
    required ErrorTypes? onError,
    List<Reminder>? reminders,
  }) {
    return DashboardState(
      isLoading: isLoading,
      onError: onError,
      reminders: reminders ?? this.reminders,
    );
  }
}