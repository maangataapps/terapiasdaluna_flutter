import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';

class CalendarState {
  bool isLoading;
  ErrorTypes? onError;
  List<CalendarEvent>? events;

  CalendarState({
    required this.isLoading,
    this.onError,
    this.events,
  });

  CalendarState copyWith({
    required bool isLoading,
    ErrorTypes? onError,
    List<CalendarEvent>? events,
  }) {
    return CalendarState(
      isLoading: isLoading,
      onError: onError ?? this.onError,
      events: events ?? this.events,
    );
  }

}