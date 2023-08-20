import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';

class SupplementsState {
  bool isLoading;
  ErrorTypes? onError;
  List<Supplement>? totalSupplements;

  SupplementsState({
    required this.isLoading,
    required this.onError,
    this.totalSupplements,
  });

  SupplementsState copyWith({
    required bool isLoading,
    required ErrorTypes? onError,
    List<Supplement>? totalSupplements,
  }) {
    return SupplementsState(
      isLoading: isLoading,
      onError: onError,
      totalSupplements: totalSupplements ?? this.totalSupplements,
    );
  }
}