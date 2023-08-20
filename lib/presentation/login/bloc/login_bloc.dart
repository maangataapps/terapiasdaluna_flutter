import 'package:firebase_auth/firebase_auth.dart';
import 'package:terapiasdaluna/domain/interactor/profile/get_user_data_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/create_user_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/do_login_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/reset_forgotten_password_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/save_terms_and_conditions_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/save_user_credentiales_interactor.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';
import 'package:terapiasdaluna/infrastructure/utils/validator_utils.dart';
import 'package:terapiasdaluna/infrastructure/extensions/extensions.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';
import 'package:terapiasdaluna/presentation/login/bloc/login_actions.dart';
import 'package:terapiasdaluna/presentation/login/bloc/login_state.dart';

class LoginBloc extends BaseBloc<LoginActions, LoginState> {
  final CreateUserInteractor createUserInteractor;
  final SaveUserCredentialsInteractor saveUserCredentialsInteractor;
  final DoLoginInteractor doLoginInteractor;
  final GetUserDataInteractor getUserDataInteractor;
  final SaveTermsAndConditionsInteractor saveTermsAndConditionsInteractor;
  final ResetForgottenPasswordInteractor resetForgottenPasswordInteractor;

  LoginBloc({
    required this.createUserInteractor,
    required this.saveUserCredentialsInteractor,
    required this.doLoginInteractor,
    required this.getUserDataInteractor,
    required this.saveTermsAndConditionsInteractor,
    required this.resetForgottenPasswordInteractor,
  }) : super(LoginState(
    isLoading: false,
    onError: null,
    isLogin: true,
    isPasswordVisible: false,
    isRepeatPasswordVisible: false,
  ),) {
    on<InitializeStateAction>((event, emit) {
      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<ChangePasswordVisibility>((event, emit) {
      state.isPasswordVisible = !state.isPasswordVisible!;

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<ChangeRepeatPasswordVisibility>((event, emit) {
      state.isRepeatPasswordVisible = !state.isRepeatPasswordVisible!;

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<ChangeLoginModeAction>((event, emit) {
      state.isLogin = !state.isLogin!;

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<CreateUserAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      try {
        final User? user = await createUserInteractor.execute(event.name, event.email, event.password);
        if (user == null) {
          emit(state.copyWith(isLoading: false, onError: ErrorTypes.userCreationNull));
        } else {
          await saveUserCredentialsInteractor.execute(event.name, user.uid, event.email, await user.getIdToken(true), false);
          await saveTermsAndConditionsInteractor.execute(event.acceptanceString, event.email);
          event.onFinish.call();
          emit(state.copyWith(isLoading: false, onError: null));
          // TODO: tema de autologin, habrá que guardar el token no? -.-
        }
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'weak-password') {
            emit(state.copyWith(isLoading: false, onError: ErrorTypes.weakPasswordError));
          } else if (e.code == 'email-already-in-use') {
            emit(state.copyWith(isLoading: false, onError: ErrorTypes.emailAlreadyInUseError));
          }
        } else {
          emit(state.copyWith(isLoading: false, onError: ErrorTypes.unknownError));
        }
      }
    });

    on<DoLoginAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      try {
        final userCredential = await doLoginInteractor.execute(event.email, event.password);
        ProfileModel profile = await getUserDataInteractor.execute(userCredential.user!.uid);
        try {
          await saveUserCredentialsInteractor.execute(
            userCredential.user!.displayName.orEmpty(),
            userCredential.user!.uid,
            userCredential.user!.email.orEmpty(),
            await userCredential.user!.getIdToken(),
            profile.userType == 0,
          );

          event.onFinish.call(profile.userType);
          emit(state.copyWith(isLoading: false, onError: null));
        } catch (saveCredentialsError) {
          emit(state.copyWith(isLoading: false, onError: ErrorTypes.unknownError));
        }
      } catch (signInError) {
        emit(state.copyWith(isLoading: false, onError: ErrorTypes.uploadProfileError));
      }
    });

    on<ForgottenPasswordAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      await resetForgottenPasswordInteractor.execute(event.email);
      event.onFinish.call();
      emit(state.copyWith(isLoading: false, onError: null));
    });
  }

  FormErrorTypes? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return FormErrorTypes.usernameEmptyOrNullError;
    }
    return null;
  }

  FormErrorTypes? validateEmail(String? value) {
    if (!state.isLogin!) {
      if (isEmail(value)) {
        return null;
      } else {
        return FormErrorTypes.emailFormatError;
      }
    } else {
      return null;
    }
  }

  FormErrorTypes? validatePassword(String? value) => validatePasswordOrNull(value);
  FormErrorTypes? validateRepeatPassword(String? value, String password) {
    if (state.isLogin!) {
      return null;
    } else {
      if (value.isEmptyOrNull()) {
        return FormErrorTypes.emptyRepeatPassword;
      } else {
        if (validatePasswordOrNull(password) == null) {
          if (value != password) {
            return FormErrorTypes.repeatPasswordError;
          } else {
            return null;
          }
        } else {
          return null;
        }
      }
    }
  }
}