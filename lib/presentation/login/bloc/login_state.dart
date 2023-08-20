import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';

class LoginState {
  bool isLoading;
  ErrorTypes? onError;
  bool? isLogin;
  bool? isPasswordVisible;
  bool? isRepeatPasswordVisible;

  LoginState({
    required this.isLoading,
    required this.onError,
    this.isLogin,
    this.isPasswordVisible,
    this.isRepeatPasswordVisible,
  });

  LoginState copyWith({
    required bool isLoading,
    required ErrorTypes? onError,
    bool? isLogin,
    bool? isPasswordVisible,
    bool? isRepeatPasswordVisible,
  }) {
    return LoginState(
      isLoading: isLoading,
      onError: onError,
      isLogin: isLogin ?? this.isLogin,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isRepeatPasswordVisible: isRepeatPasswordVisible ?? this.isRepeatPasswordVisible,
    );
  }
}