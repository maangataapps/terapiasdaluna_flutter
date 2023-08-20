import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';

class AdminState {
  bool isLoading;
  ErrorTypes? onError;
  List<ProfileModel>? users;

  AdminState({
    required this.isLoading,
    required this.onError,
    this.users,
  });

  AdminState copyWith({
    required bool isLoading,
    required ErrorTypes? onError,
    List<ProfileModel>? users,
  }) {
    return AdminState(
      isLoading: isLoading,
      onError: onError,
      users: users ?? this.users,
    );
  }
}