import 'package:terapiasdaluna/domain/interactor/profile/upload_profile_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_username_interactor.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';
import 'package:terapiasdaluna/presentation/registry/bloc/registry_actions.dart';
import 'package:terapiasdaluna/presentation/registry/bloc/registry_state.dart';

class RegistryBloc extends BaseBloc<RegistryActions, RegistryState> {
  final UploadProfileInteractor uploadProfileInteractor;
  final GetUserIdInteractor getUserIdInteractor;
  final GetUsernameInteractor getUsernameInteractor;

  RegistryBloc({
    required this.uploadProfileInteractor,
    required this.getUserIdInteractor,
    required this.getUsernameInteractor,
  }) : super(RegistryState(
    isLoading: false,
    onError: null,
    profileModel: ProfileModel.empty(),
  ),) {
    on<InitializeStateAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));

      state.profileModel!.userType = UserType.user.index;
      state.profileModel!.userId = getUserIdInteractor.execute();
      state.profileModel!.name = getUsernameInteractor.execute();

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SetBirthdateAction>((event, emit) {
      state.profileModel!.birthDate = event.birthdate.millisecondsSinceEpoch;

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SetSexAction>((event, emit) {
      state.profileModel!.sex = event.sexType.index;

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SetHeightAction>((event, emit) {
      state.profileModel!.height = event.height;

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SetWeightAction>((event, emit) {
      state.profileModel!.weight = event.weight;

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SaveProfileAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      if (state.profileModel != null) {
        if (state.profileModel!.height == -1) {

          emit(state.copyWith(isLoading: false, onError: ErrorTypes.heightError));
        } else if (state.profileModel!.weight == -1) {

          emit(state.copyWith(isLoading: false, onError: ErrorTypes.weightError));
        } else if (state.profileModel!.birthDate == -1) {

          emit(state.copyWith(isLoading: false, onError: ErrorTypes.birthDateError));
        } else if (state.profileModel!.sex == -1) {

          emit(state.copyWith(isLoading: false, onError: ErrorTypes.sexError));
        } else {
          try {
            await uploadProfileInteractor.execute(state.profileModel!);
            event.onFinish.call();
            emit(state.copyWith(isLoading: false, onError: null));
          } catch (uploadProfileError) {
            emit(state.copyWith(isLoading: false, onError: ErrorTypes.uploadProfileError));
          }
        }
      }
    });
  }

}