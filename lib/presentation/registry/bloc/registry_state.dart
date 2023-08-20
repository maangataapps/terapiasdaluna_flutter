import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';

class RegistryState {
  bool isLoading;
  ErrorTypes? onError;
  ProfileModel? profileModel;

  RegistryState({
    required this.isLoading,
    required this.onError,
    this.profileModel,
  });

  RegistryState copyWith({
    required bool isLoading,
    required ErrorTypes? onError,
    ProfileModel? profileModel,
  }) {
    return RegistryState(
      isLoading: isLoading,
      onError: onError,
      profileModel: profileModel ?? this.profileModel,
    );
  }
}