import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/dashboard/get_reminders_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/dashboard/perform_log_out_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/save_supplement_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/clear_credentials_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';
import 'package:terapiasdaluna/presentation/dashboard/bloc/dashboard_actions.dart';
import 'package:terapiasdaluna/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:terapiasdaluna/presentation/dashboard/model/reminder.dart';

class DashboardBloc extends BaseBloc<DashboardActions, DashboardState> {
  final GetUserIdInteractor getUserIdInteractor;
  final GetRemindersInteractor getRemindersInteractor;
  final SaveSupplementEventInteractor saveSupplementEventInteractor;
  final PerformLogOutInteractor performLogOutInteractor;
  final ClearCredentialsInteractor clearCredentialsInteractor;

  final StreamController<List<Reminder>> _streamRemindersController = StreamController<List<Reminder>>.broadcast();
  late Stream<List<Reminder>> streamRemindersStream = _streamRemindersController.stream;

  DashboardBloc({
    required this.getUserIdInteractor,
    required this.getRemindersInteractor,
    required this.saveSupplementEventInteractor,
    required this.performLogOutInteractor,
    required this.clearCredentialsInteractor,
  }) : super(DashboardState(
    isLoading: false,
    onError: null,
    reminders: [],
  ),) {
    on<InitializeStateAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      final userId = getUserIdInteractor.execute();
      await getRemindersInteractor.execute(userId).then((value) => state.reminders = value);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SaveSupplementEventFromDashboardAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      await saveSupplementEventInteractor.execute(event.supplementEvent, event.onFinish);
      final reminder = state.reminders!.firstWhere((reminder) => reminder.supplementEvent.eventId == event.supplementEvent.eventId)..hasBeenTaken = true;
      final reminderIndex = state.reminders!.indexOf(reminder);
      state.reminders!.replaceRange(reminderIndex, reminderIndex+1, [reminder]);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<PerformLogOutAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      await performLogOutInteractor.execute();
      await clearCredentialsInteractor.execute();
      event.onFinish.call();

      emit(state.copyWith(isLoading: false, onError: null));
    });
  }

  // List<Image> populateMoonCarousel(int moonsQuantity) => List<Image>.filled(moonsQuantity, Image.asset(ImageHelper().logo,));
}