import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terapiasdaluna/data/repository/admin/admin_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/calendar/calendar_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/dashboard/dashboard_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/foodevents/food_events_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/poopevents/poop_events_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/preferences/preferences_impl.dart';
import 'package:terapiasdaluna/data/repository/preferences/preferences_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/profile/profile_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/questions/questions_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/sleepevents/sleep_events_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/sportevents/sport_events_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/supplements/supplements_repository_impl.dart';
import 'package:terapiasdaluna/data/repository/user/user_repository_impl.dart';
import 'package:terapiasdaluna/domain/interactor/admin/get_users_list_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/admin/get_users_list_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/admin/save_request_user_id_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/admin/save_request_user_id_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/calendar/filter_events_by_date_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/calendar/filter_events_by_date_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/calendar/get_total_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/calendar/get_total_events_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/calendar/listen_to_calendar_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/calendar/listen_to_calendar_events_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/dashboard/get_reminders_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/dashboard/get_reminders_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/dashboard/perform_log_out_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/dashboard/perform_log_out_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/delete_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/delete_food_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/edit_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/edit_food_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/listen_to_food_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/listen_to_food_events_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/save_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/save_food_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/delete_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/delete_poop_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/edit_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/edit_poop_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/listen_to_poop_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/listen_to_poop_events_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/save_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/save_poop_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/profile/get_user_data_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/profile/get_user_data_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/profile/upload_profile_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/profile/upload_profile_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/questions/save_questionnaire_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/questions/save_questionnaire_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/delete_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/delete_sleep_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/edit_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/edit_sleep_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/listen_to_sleep_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/listen_to_sleep_events_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/save_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/save_sleep_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/delete_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/delete_sport_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/edit_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/edit_sport_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/listen_to_sport_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/listen_to_sport_events_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/save_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/save_sport_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/delete_supplement_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/delete_supplement_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/edit_supplement_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/edit_supplement_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/edit_supplement_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/edit_supplement_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/listen_to_supplement_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/listen_to_supplement_events_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/listen_to_supplements_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/listen_to_supplements_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/save_supplement_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/save_supplement_event_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/save_supplement_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/save_supplement_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/user/clear_credentials_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/clear_credentials_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/user/create_user_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/create_user_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/user/do_login_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/do_login_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_username_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_username_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/user/reset_forgotten_password_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/reset_forgotten_password_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/user/save_terms_and_conditions_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/save_terms_and_conditions_interactor_impl.dart';
import 'package:terapiasdaluna/domain/interactor/user/save_user_credentiales_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/save_user_credentiales_interactor_impl.dart';
import 'package:terapiasdaluna/domain/repository/admin/admin_repository.dart';
import 'package:terapiasdaluna/domain/repository/calendar/calendar_repository.dart';
import 'package:terapiasdaluna/domain/repository/dashboard/dashboard_repository.dart';
import 'package:terapiasdaluna/domain/repository/foodevents/food_events_repository.dart';
import 'package:terapiasdaluna/domain/repository/poopevents/poop_events_repository.dart';
import 'package:terapiasdaluna/domain/repository/preferences/preferences.dart';
import 'package:terapiasdaluna/domain/repository/preferences/preferences_repository.dart';
import 'package:terapiasdaluna/domain/repository/profile/profile_repository.dart';
import 'package:terapiasdaluna/domain/repository/questions/questions_repository.dart';
import 'package:terapiasdaluna/domain/repository/sleepevents/sleep_events_repository.dart';
import 'package:terapiasdaluna/domain/repository/sportevents/sport_events_repository.dart';
import 'package:terapiasdaluna/domain/repository/supplements/supplements_repository.dart';
import 'package:terapiasdaluna/domain/repository/user/user_repository.dart';
import 'package:terapiasdaluna/infrastructure/environment/environment.dart';
import 'package:terapiasdaluna/infrastructure/helpers/i10n_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/presentation/admin/bloc/admin_bloc.dart';
import 'package:terapiasdaluna/presentation/admin/view/admin_screen.dart';
import 'package:terapiasdaluna/presentation/base/bloc/test_bloc.dart';
import 'package:terapiasdaluna/presentation/base/view/test_widget_screen.dart';
import 'package:terapiasdaluna/presentation/calendar/bloc/calendar_bloc.dart';
import 'package:terapiasdaluna/presentation/calendar/view/calendar_screen.dart';
import 'package:terapiasdaluna/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:terapiasdaluna/presentation/dashboard/view/dashboard_screen.dart';
import 'package:terapiasdaluna/presentation/foodevents/bloc/food_events_bloc.dart';
import 'package:terapiasdaluna/presentation/foodevents/view/food_events_screen.dart';
import 'package:terapiasdaluna/presentation/login/bloc/login_bloc.dart';
import 'package:terapiasdaluna/presentation/login/view/login_screen.dart';
import 'package:terapiasdaluna/presentation/poopevents/bloc/poop_events_bloc.dart';
import 'package:terapiasdaluna/presentation/poopevents/view/poop_events_screen.dart';
import 'package:terapiasdaluna/presentation/questions/bloc/questions_bloc.dart';
import 'package:terapiasdaluna/presentation/questions/view/questions_screen.dart';
import 'package:terapiasdaluna/presentation/registry/bloc/registry_bloc.dart';
import 'package:terapiasdaluna/presentation/registry/view/registry_screen.dart';
import 'package:terapiasdaluna/presentation/sleepevents/bloc/sleep_events_bloc.dart';
import 'package:terapiasdaluna/presentation/sleepevents/view/sleep_events_screen.dart';
import 'package:terapiasdaluna/presentation/sportevents/bloc/sport_events_bloc.dart';
import 'package:terapiasdaluna/presentation/sportevents/view/sport_events_screen.dart';
import 'package:terapiasdaluna/presentation/supplements/bloc/supplements_bloc.dart';
import 'package:terapiasdaluna/presentation/supplements/view/supplements_screen.dart';
import 'firebase_options.dart';

void main() async {
  const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: Environment.staging);
  Environment().initConfig(environment);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) FirebaseDatabase.instance.setPersistenceEnabled(true);

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final Preferences prefs = PreferencesImpl(sharedPreferences);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final PreferencesRepository preferencesRepository = PreferencesRepositoryImpl(prefs: prefs);
  final UserRepository userRepository = UserRepositoryImpl(auth: auth);
  final CreateUserInteractor createUserInteractor = CreateUserInteractorImpl(
    userRepository: userRepository,
    preferences: preferencesRepository,
  );
  final SaveUserCredentialsInteractor saveUserCredentialsInteractor = SaveUserCredentialsInteractorImpl(preferencesRepository: preferencesRepository);
  final ProfileRepository profileRepository = ProfileRepositoryImpl(firebaseDatabase: firebaseDatabase, preferencesRepository: preferencesRepository);
  final UploadProfileInteractor uploadProfileInteractor = UploadProfileInteractorImpl(profileRepository: profileRepository);
  final GetUserIdInteractor getUserIdInteractor = GetUserIdInteractorImpl(preferencesRepository: preferencesRepository);
  final GetUsernameInteractor getUsernameInteractor = GetUsernameInteractorImpl(preferencesRepository: preferencesRepository);
  final DoLoginInteractor doLoginInteractor = DoLoginInteractorImpl(userRepository: userRepository);
  final FoodEventsRepository foodEventsRepository = FoodEventsRepositoryImpl(firebaseDatabase: firebaseDatabase);
  final ListenToFoodEventsInteractor listenToFoodEventsInteractor = ListenToFoodEventsInteractorImpl(foodEventsRepository: foodEventsRepository);
  final SportEventsRepository sportEventsRepository = SportEventsRepositoryImpl(firebaseDatabase: firebaseDatabase);
  final ListenToSportEventsInteractor listenToSportEventsInteractor = ListenToSportEventsInteractorImpl(sportEventsRepository: sportEventsRepository);
  final SaveFoodEventInteractor saveFoodEventInteractor = SaveFoodEventInteractorImpl(foodEventsRepository: foodEventsRepository);
  final SaveSportEventInteractor saveSportEventInteractor = SaveSportEventInteractorImpl(sportEventsRepository: sportEventsRepository);
  final DeleteFoodEventInteractor deleteFoodEventInteractor = DeleteFoodEventInteractorImpl(foodEventsRepository: foodEventsRepository);
  final DeleteSportEventInteractor deleteSportEventInteractor = DeleteSportEventInteractorImpl(sportEventsRepository: sportEventsRepository);
  final EditFoodEventInteractor editFoodEventInteractor = EditFoodEventInteractorImpl(foodEventsRepository: foodEventsRepository);
  final EditSportEventInteractor editSportEventInteractor = EditSportEventInteractorImpl(sportEventsRepository: sportEventsRepository);
  final SleepEventsRepository sleepEventsRepository = SleepEventsRepositoryImpl(firebaseDatabase: firebaseDatabase);
  final ListenToSleepEventsInteractor listenToSleepEventsInteractor = ListenToSleepEventsInteractorImpl(sleepEventsRepository: sleepEventsRepository);
  final SaveSleepEventInteractor saveSleepEventInteractor = SaveSleepEventInteractorImpl(sleepEventsRepository: sleepEventsRepository);
  final DeleteSleepEventInteractor deleteSleepEventInteractor = DeleteSleepEventInteractorImpl(sleepEventsRepository: sleepEventsRepository);
  final EditSleepEventInteractor editSleepEventInteractor = EditSleepEventInteractorImpl(sleepEventsRepository: sleepEventsRepository);
  final PoopEventsRepository poopEventsRepository = PoopEventsRepositoryImpl(firebaseDatabase: firebaseDatabase);
  final ListenToPoopEventsInteractor listenToPoopEventsInteractor = ListenToPoopEventsInteractorImpl(poopEventsRepository: poopEventsRepository);
  final SavePoopEventInteractor savePoopEventInteractor = SavePoopEventInteractorImpl(poopEventsRepository: poopEventsRepository);
  final DeletePoopEventInteractor deletePoopEventInteractor = DeletePoopEventInteractorImpl(poopEventsRepository: poopEventsRepository);
  final EditPoopEventInteractor editPoopEventInteractor = EditPoopEventInteractorImpl(poopEventsRepository: poopEventsRepository);
  final CalendarRepository calendarRepository = CalendarRepositoryImpl(firebaseDatabase: firebaseDatabase);
  final ListenToCalendarEventsInteractor listenToCalendarEventsInteractor = ListenToCalendarEventsInteractorImpl(calendarRepository: calendarRepository);
  final FilterEventsByDateInteractor filterEventsByDateInteractor = FilterEventsByDateInteractorImpl(calendarRepository: calendarRepository);
  final GetTotalEventsInteractor getTotalEventsInteractor = GetTotalEventsInteractorImpl(calendarRepository: calendarRepository);
  final SupplementsRepository supplementsRepository = SupplementsRepositoryImpl(firebaseDatabase: firebaseDatabase);
  final SaveSupplementInteractor saveSupplementInteractor = SaveSupplementInteractorImpl(supplementsRepository: supplementsRepository);
  final ListenToSupplementsInteractor listenToSupplementsInteractor = ListenToSupplementsInteractorImpl(supplementsRepository: supplementsRepository);
  final SaveSupplementEventInteractor saveSupplementEventInteractor = SaveSupplementEventInteractorImpl(supplementsRepository: supplementsRepository);
  final ListenToSupplementEventsInteractor listenToSupplementEventsInteractor = ListenToSupplementEventsInteractorImpl(supplementsRepository: supplementsRepository);
  final EditSupplementInteractor editSupplementInteractor = EditSupplementInteractorImpl(supplementsRepository: supplementsRepository);
  final EditSupplementEventInteractor editSupplementEventInteractor = EditSupplementEventInteractorImpl(supplementsRepository: supplementsRepository);
  final DeleteSupplementEventInteractor deleteSupplementEventInteractor = DeleteSupplementEventInteractorImpl(supplementsRepository: supplementsRepository);
  final DashboardRepository dashboardRepository = DashboardRepositoryImpl(firebaseDatabase: firebaseDatabase);
  final GetRemindersInteractor getRemindersInteractor = GetRemindersInteractorImpl(dashboardRepository: dashboardRepository);
  final GetUserDataInteractor getUserDataInteractor = GetUserDataInteractorImpl(profileRepository: profileRepository);
  final AdminRepository adminRepository = AdminRepositoryImpl(firebaseDatabase: firebaseDatabase, preferencesRepository: preferencesRepository);
  final GetUsersListInteractor getUsersListInteractor = GetUsersListInteractorImpl(adminRepository: adminRepository);
  final SaveRequestUserIdInteractor saveRequestUserIdInteractor = SaveRequestUserIdInteractorImpl(adminRepository: adminRepository);
  final PerformLogOutInteractor performLogOutInteractor = PerformLogOutInteractorImpl(userRepository: userRepository);
  final ClearCredentialsInteractor clearCredentialsInteractor = ClearCredentialsInteractorImpl(preferencesRepository: preferencesRepository);
  final QuestionsRepository questionsRepository = QuestionsRepositoryImpl(firebaseDatabase: firebaseDatabase);
  final SaveQuestionnaireInteractor saveQuestionnaireInteractor = SaveQuestionnaireInteractorImpl(questionsRepository: questionsRepository);
  final SaveTermsAndConditionsInteractor saveTermsAndConditionsInteractor = SaveTermsAndConditionsInteractorImpl(profileRepository: profileRepository);
  final ResetForgottenPasswordInteractor resetForgottenPasswordInteractor = ResetForgottenPasswordInteractorImpl(userRepository: userRepository);

  final testBloc = TestBloc();
  final loginBloc = LoginBloc(
    createUserInteractor: createUserInteractor,
    saveUserCredentialsInteractor: saveUserCredentialsInteractor,
    doLoginInteractor: doLoginInteractor,
    getUserDataInteractor: getUserDataInteractor,
    saveTermsAndConditionsInteractor: saveTermsAndConditionsInteractor,
    resetForgottenPasswordInteractor: resetForgottenPasswordInteractor,

  );
  final registryBloc = RegistryBloc(
    uploadProfileInteractor: uploadProfileInteractor,
    getUserIdInteractor: getUserIdInteractor,
    getUsernameInteractor: getUsernameInteractor,
  );
  final dashboardBloc = DashboardBloc(
    getUserIdInteractor: getUserIdInteractor,
    getRemindersInteractor: getRemindersInteractor,
    saveSupplementEventInteractor: saveSupplementEventInteractor,
    performLogOutInteractor: performLogOutInteractor,
    clearCredentialsInteractor: clearCredentialsInteractor,
  );
  final foodEventsBloc = FoodEventsBloc(
    listenToFoodEventsInteractor: listenToFoodEventsInteractor,
    getUserIdInteractor: getUserIdInteractor,
    saveFoodEventInteractor: saveFoodEventInteractor,
    deleteFoodEventInteractor: deleteFoodEventInteractor,
    editFoodEventInteractor: editFoodEventInteractor,
  );
  final sportEventsBloc = SportEventsBloc(
      listenToSportEventsInteractor: listenToSportEventsInteractor,
      getUserIdInteractor: getUserIdInteractor,
      saveSportEventInteractor: saveSportEventInteractor,
      deleteSportEventInteractor: deleteSportEventInteractor,
      editSportEventInteractor: editSportEventInteractor,
  );
  final sleepEventsBloc = SleepEventsBloc(
      listenToSleepEventsInteractor: listenToSleepEventsInteractor,
      getUserIdInteractor: getUserIdInteractor,
      saveSleepEventInteractor: saveSleepEventInteractor,
      deleteSleepEventInteractor: deleteSleepEventInteractor,
      editSleepEventInteractor: editSleepEventInteractor,
  );
  final poopEventsBloc = PoopEventsBloc(
    deletePoopEventInteractor: deletePoopEventInteractor,
    editPoopEventInteractor: editPoopEventInteractor,
    getUserIdInteractor: getUserIdInteractor,
    listenToPoopEventsInteractor: listenToPoopEventsInteractor,
    savePoopEventInteractor: savePoopEventInteractor,
  );
  final calendarBloc = CalendarBloc(
    listenToCalendarEventsInteractor: listenToCalendarEventsInteractor,
    getUserIdInteractor: getUserIdInteractor,
    editFoodEventInteractor: editFoodEventInteractor,
    editSportEventInteractor: editSportEventInteractor,
    editSleepEventInteractor: editSleepEventInteractor,
    editPoopEventInteractor: editPoopEventInteractor,
    deleteFoodEventInteractor: deleteFoodEventInteractor,
    deleteSportEventInteractor: deleteSportEventInteractor,
    deleteSleepEventInteractor: deleteSleepEventInteractor,
    deletePoopEventInteractor: deletePoopEventInteractor,
    filterEventsByDateInteractor: filterEventsByDateInteractor,
    getTotalEventsInteractor: getTotalEventsInteractor,
  );
  final supplementsBloc = SupplementsBloc(
    getUserIdInteractor: getUserIdInteractor,
    saveSupplementInteractor: saveSupplementInteractor,
    listenToSupplementsInteractor: listenToSupplementsInteractor,
    saveSupplementEventInteractor: saveSupplementEventInteractor,
    listenToSupplementEventsInteractor: listenToSupplementEventsInteractor,
    editSupplementInteractor: editSupplementInteractor,
    editSupplementEventInteractor: editSupplementEventInteractor,
    deleteSupplementEventInteractor: deleteSupplementEventInteractor,
  );
  final adminBloc = AdminBloc(
    getUsersListInteractor: getUsersListInteractor,
    saveRequestUserIdInteractor: saveRequestUserIdInteractor,
  );
  final questionsBloc = QuestionsBloc(
    getUserIdInteractor: getUserIdInteractor,
    saveQuestionnaireInteractor: saveQuestionnaireInteractor,
  );

  runApp(
    // MultiProvider(
    MultiBlocProvider(
      providers: [
        BlocProvider<TestBloc>(create: (ctx) => testBloc),
        BlocProvider<LoginBloc>(create: (ctx) => loginBloc),
        BlocProvider<RegistryBloc>(create: (ctx) => registryBloc),
        BlocProvider<DashboardBloc>(create: (ctx) => dashboardBloc),
        BlocProvider<FoodEventsBloc>(create: (ctx) => foodEventsBloc),
        BlocProvider<SportEventsBloc>(create: (ctx) => sportEventsBloc),
        BlocProvider<SleepEventsBloc>(create: (ctx) => sleepEventsBloc),
        BlocProvider<PoopEventsBloc>(create: (ctx) => poopEventsBloc),
        BlocProvider<CalendarBloc>(create: (ctx) => calendarBloc),
        BlocProvider<SupplementsBloc>(create: (ctx) => supplementsBloc),
        BlocProvider<AdminBloc>(create: (ctx) => adminBloc),
        BlocProvider<QuestionsBloc>(create: (ctx) => questionsBloc),
      ],
      child: MaterialApp(
        title: 'Terapias da Luna',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSwatch().copyWith(),
        ),
        initialRoute: '/',
        localizationsDelegates: const [
          AppLocalizationsHelperDelegate(),
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('es', ''), // Spanish, no country code
          Locale('pt', ''), // Portuguese, no country code
        ],
        routes: {
          '/': (ctx) => const LoginScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          RegistryScreen.routeName: (ctx) => const RegistryScreen(),
          TestWidgetScreen.routeName: (ctx) => const TestWidgetScreen(),
          DashboardScreen.routeName: (ctx) => const DashboardScreen(),
          FoodEventsScreen.routeName: (ctx) => const FoodEventsScreen(),
          SportEventsScreen.routeName: (ctx) => const SportEventsScreen(),
          SleepEventsScreen.routeName: (ctx) => const SleepEventsScreen(),
          PoopEventsScreen.routeName: (ctx) => const PoopEventsScreen(),
          CalendarScreen.routeName: (ctx) => const CalendarScreen(),
          SupplementsScreen.routeName: (ctx) => const SupplementsScreen(),
          AdminScreen.routeName: (ctx) => const AdminScreen(),
          QuestionsScreen.routeName: (ctx) => const QuestionsScreen(),
        },
      ),
    ),
  );
}