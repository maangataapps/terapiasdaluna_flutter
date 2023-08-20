import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';

class SportEventsState {
  bool isLoading;
  ErrorTypes? onError;

  SportEventsState({
    required this.isLoading,
    required this.onError,
  });

  SportEventsState copyWith({
    required bool isLoading,
    required ErrorTypes? onError,
    List<SportEvent>? foodEvents,
  }) {
    return SportEventsState(
      isLoading: isLoading,
      onError: onError,
    );
  }
}