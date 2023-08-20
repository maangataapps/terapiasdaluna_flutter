import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/admin/get_users_list_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/admin/save_request_user_id_interactor.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/presentation/admin/bloc/admin_actions.dart';
import 'package:terapiasdaluna/presentation/admin/bloc/admin_state.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';

class AdminBloc extends BaseBloc<AdminActions, AdminState> {
  final GetUsersListInteractor getUsersListInteractor;
  final SaveRequestUserIdInteractor saveRequestUserIdInteractor;

  final StreamController<List<ProfileModel>> _streamController = StreamController<List<ProfileModel>>.broadcast();
  late Stream<List<ProfileModel>> streamStream = _streamController.stream;

  AdminBloc({
    required this.getUsersListInteractor,
    required this.saveRequestUserIdInteractor,
  }) : super(AdminState(
    isLoading: false,
    onError: null,
    users: [],
  ),) {
    on<InitialiseStateAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      state.users = await getUsersListInteractor.execute().then((value) => value);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SelectUserAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      await saveRequestUserIdInteractor.execute(event.user.userId);

      event.onFinish.call();
      emit(state.copyWith(isLoading: false, onError: null));
    });
  }

}