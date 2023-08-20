import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';

class FoodEventsState {
  bool isLoading;
  ErrorTypes? onError;

  FoodEventsState({
    required this.isLoading,
    required this.onError,
  });

  FoodEventsState copyWith({
    required bool isLoading,
    required ErrorTypes? onError,
  }) {
    return FoodEventsState(
      isLoading: isLoading,
      onError: onError,
    );
  }
}