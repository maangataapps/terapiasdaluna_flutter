import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';

class SleepEventsState {
  bool isLoading;
  ErrorTypes? onError;

  SleepEventsState({
    required this.isLoading,
    required this.onError,
  });

  SleepEventsState copyWith({
    required bool isLoading,
    required ErrorTypes? onError,
  }) {
    return SleepEventsState(
      isLoading: isLoading,
      onError: onError,
    );
  }
}