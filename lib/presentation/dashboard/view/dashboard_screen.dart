import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/helpers/dialog_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/image_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/calendar/view/calendar_screen.dart';
import 'package:terapiasdaluna/presentation/dashboard/bloc/dashboard_actions.dart';
import 'package:terapiasdaluna/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:terapiasdaluna/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:terapiasdaluna/presentation/foodevents/view/food_events_screen.dart';
import 'package:terapiasdaluna/presentation/login/view/login_screen.dart';
import 'package:terapiasdaluna/presentation/poopevents/view/poop_events_screen.dart';
import 'package:terapiasdaluna/presentation/questions/view/questions_screen.dart';
import 'package:terapiasdaluna/presentation/sleepevents/view/sleep_events_screen.dart';
import 'package:terapiasdaluna/presentation/sportevents/view/sport_events_screen.dart';
import 'package:terapiasdaluna/presentation/supplements/view/supplements_screen.dart';
import 'package:terapiasdaluna/presentation/widgets/dashboard_wheel.dart';
import 'package:terapiasdaluna/presentation/widgets/no_events_card.dart';
import 'package:terapiasdaluna/presentation/widgets/reminder_item_list.dart';
import 'package:terapiasdaluna/presentation/widgets/splash_rounded_button.dart';
import 'package:terapiasdaluna/presentation/widgets/top_label.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dialogHelper = DialogHelper();

  @override
  void initState() {
    final bloc = BlocProvider.of<DashboardBloc>(context);
    bloc.add(InitializeStateAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DashboardBloc>(context);
    final mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocProvider.value(
        value: bloc,
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            elevation: 5,
            shadowColor: Colors.teal,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Terapias da Luna',
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: Dimens.fontSizeXLarge*1.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          body: BlocConsumer<DashboardBloc, DashboardState>(
            listener: (ctx, state) {
              if (state.isLoading) {
                LoadingScreen.instance().show(
                  context: ctx,
                  text: AppLocalizations.of(ctx)!.loading,
                );
              } else {
                LoadingScreen.instance().hide();
              }
              if (state.onError != null) {
                showSnackBarError(context, resolveError(ctx, state.onError!));
              }
            },
            builder: (ctx, state) {
              return Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.all(Dimens.marginNormal),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Card(
                                shape: const CircleBorder(),
                                shadowColor: Colors.red,
                                child: IconButton(
                                  splashRadius: 25.0,
                                  highlightColor: Colors.red,
                                  icon: const Icon(Icons.power_settings_new),
                                  iconSize: 40,
                                  color: Colors.black,
                                  onPressed: () => _dialogHelper.showLogOutDialog(
                                    context,
                                    onFinish: () => bloc.add(PerformLogOutAction(
                                      onFinish: () => Navigator.popAndPushNamed(context, LoginScreen.routeName),
                                    ),),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(Dimens.marginNormal),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    shape: const CircleBorder(),
                                    shadowColor: AppColors.questionsColor,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: SplashRoundedButton(
                                        splashRadius: mediaQuery.width/10,
                                        imagePath: ImageHelper().controlImage,
                                        iconSize: mediaQuery.width/8,
                                        splashColor: AppColors.questionsColor,
                                        onPressed: () => Navigator.pushNamed(context, QuestionsScreen.routeName),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    shape: const CircleBorder(),
                                    shadowColor: AppColors.supplementsColor,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: SplashRoundedButton(
                                        splashRadius: mediaQuery.width/10,
                                        imagePath: ImageHelper().supplementImage,
                                        iconSize: mediaQuery.width/8,
                                        splashColor: AppColors.supplementsColor,
                                        onPressed: () => Navigator.pushNamed(context, SupplementsScreen.routeName).then((value) => bloc.add(InitializeStateAction())),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          child: DashboardWheel(
                            width: mediaQuery.width*0.9,
                            onClickFoods: () => Navigator.pushNamed(context, FoodEventsScreen.routeName),
                            onClickSports: () => Navigator.pushNamed(context, SportEventsScreen.routeName),
                            onClickSleep: () => Navigator.pushNamed(context, SleepEventsScreen.routeName),
                            onClickPoopsies: () => Navigator.pushNamed(context, PoopEventsScreen.routeName),
                            onClickCalendar: () => Navigator.pushNamed(context, CalendarScreen.routeName).then((value) => bloc.add(InitializeStateAction())),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.reminderColor,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: Dimens.marginXXLarge),
                            child: SingleChildScrollView(
                              child: state.reminders!.isNotEmpty
                                  ? Column(
                                children: [
                                  ...state.reminders!.map((reminder) => ReminderItemList(
                                    reminder: reminder,
                                    onClickSave: () => _dialogHelper.showAddSupplementEventFromDashboardDialog(
                                      context: context,
                                      supplementEvent: reminder.supplementEvent,
                                      onFinish: () => bloc.add(SaveSupplementEventFromDashboardAction(
                                        supplementEvent: reminder.supplementEvent,
                                        onFinish: () => Navigator.pop(context),
                                      ),),
                                    ),
                                  ),).toList()
                                ],
                              )
                                  : NoEventsCard(color: AppColors.reminderColor, message: AppLocalizations.of(context)!.no_events_message),
                            ),
                          ),
                          TopLabel(
                            backgroundColor: AppColors.reminderColor,
                            textColor: Colors.white,
                            label: AppLocalizations.of(context)!.reminders,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}