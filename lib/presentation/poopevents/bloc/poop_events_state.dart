import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';

class PoopEventsState {
  bool isLoading;
  ErrorTypes? onError;

  PoopEventsState({
    required this.isLoading,
    required this.onError,
  });

  PoopEventsState copyWith({
    required bool isLoading,
    required ErrorTypes? onError,
  }) {
    return PoopEventsState(
      isLoading: isLoading,
      onError: onError,
    );
  }
}