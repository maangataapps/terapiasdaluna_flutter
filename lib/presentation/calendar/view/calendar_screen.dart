import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/dialog_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/calendar/bloc/calendar_actions.dart';
import 'package:terapiasdaluna/presentation/calendar/bloc/calendar_bloc.dart';
import 'package:terapiasdaluna/presentation/calendar/bloc/calendar_state.dart';
import 'package:terapiasdaluna/presentation/widgets/dots_in_calendar_widget.dart';
import 'package:terapiasdaluna/presentation/widgets/event_item_list.dart';
import 'package:terapiasdaluna/presentation/widgets/poop_event_item_list.dart';
import 'package:terapiasdaluna/presentation/widgets/questionnaire_list_item.dart';
import 'package:terapiasdaluna/presentation/widgets/sleep_event_item_list.dart';
import 'package:terapiasdaluna/presentation/widgets/supplement_event_list_item.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar_screen';

  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final dateTimeHelper = DateTimeHelper();
  DateTime _selectedDay = DateTimeHelper().provideCurrentDate();
  DateTime _focusedDay = DateTimeHelper().provideCurrentDate();
  final _dialogHelper = DialogHelper();

  @override
  void initState() {
    final bloc = BlocProvider.of<CalendarBloc>(context);
    bloc.add(InitializeStateAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CalendarBloc>(context);

    return BlocProvider.value(
      value: bloc,
      child: SafeArea(
        child: BlocConsumer<CalendarBloc, CalendarState>(
          listener: (ctx, state) {
            if (state.isLoading) {
              LoadingScreen.instance().show(
                context: ctx,
                text: AppLocalizations.of(ctx)!.loading,
              );
            } else {
              LoadingScreen.instance().hide();
            }
          },
          builder: (ctx, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 5,
                shadowColor: AppColors.calendarColor,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.calendarColor, size: 25,),
                ),
                titleSpacing: Dimens.marginNormal,
                title: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: Dimens.marginNormal),
                      child: Text(
                        AppLocalizations.of(context)!.calendar,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: Dimens.fontSizeXLarge,
                        ),
                      ),
                    ),
                    Container(
                      height: 28,
                      margin: const EdgeInsets.only(left: Dimens.marginNormal),
                      child: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),
              body: StreamBuilder<List<CalendarEvent>>(
                stream: bloc.streamStream,
                builder: (ctx, snapshot) => Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(Dimens.marginNormal),
                      child: Card(
                        shadowColor: AppColors.calendarColor,
                        elevation: 5,
                        child: TableCalendar(
                          firstDay: bloc.provideFirstDay(),
                          focusedDay: _focusedDay,
                          lastDay: bloc.provideLastDay(),
                          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              final isSameDay = dateTimeHelper.isSameDay(_selectedDay, selectedDay);
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                              if (!isSameDay) bloc.add(SelectDayEventsActions(selectedDay: _selectedDay));

                            });
                          },
                          onPageChanged: (focusedDay) => _focusedDay = focusedDay,
                          calendarStyle: CalendarStyle(
                            outsideDaysVisible: false,
                            selectedDecoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.calendarColor,
                            ),
                            todayDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.calendarColor[200],
                            )
                          ),
                          eventLoader: (date) => bloc.getEventsForDay(date),
                          calendarBuilders: CalendarBuilders(
                            markerBuilder: (context, date, events) {
                              events as List<CalendarEvent>;
                              return DotsInCalendarWidget(
                                foodEvents: bloc.areThereEventsOfType(events, FoodEvent),
                                sportEvents: bloc.areThereEventsOfType(events, SportEvent),
                                sleepEvents: bloc.areThereEventsOfType(events, SleepEvent),
                                poopEvents: bloc.areThereEventsOfType(events, PoopEvent),
                                supplementEvents: bloc.areThereEventsOfType(events, SupplementEvent),
                                questionnaires: bloc.areThereEventsOfType(events, AnsweredQuestionnaire),
                              );
                            },
                          ),
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                          ),
                        ),
                      ),
                    ),
                    if (snapshot.data == null || snapshot.data!.isEmpty) Container(
                      margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal),
                      child: Card(
                        color: AppColors.calendarColor[200],
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.empty_events_calendar,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontSize: Dimens.fontSizeLarge-2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (snapshot.data != null) Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.all(Dimens.marginNormal),
                          child: Column(
                            children: [
                              ...snapshot.data!.map((calendarEvent) {
                                switch (calendarEvent.runtimeType) {
                                  case FoodEvent: {
                                    calendarEvent as FoodEvent;
                                    return EventItemList(
                                      title: calendarEvent.foodInfo,
                                      dateTime: calendarEvent.eventDate,
                                      onEdit: () => _dialogHelper.showAddFoodDialog(
                                        context: context,
                                        onFinish: (text, eventDate, onFinish) => bloc.add(EditCalendarFoodEventAction(
                                          eventId: calendarEvent.eventId,
                                          foodInfo: text,
                                          eventDate: eventDate,
                                          onFinish: () {
                                            onFinish.call();
                                            bloc.add(SelectDayEventsActions(selectedDay: _selectedDay));
                                          },
                                        ),),
                                        foodEvent: calendarEvent,
                                      ),
                                      onDelete: () => bloc.add(DeleteCalendarEventAction(calendarEvent: calendarEvent, onFinish: () => bloc.add(InitializeStateAction()))),
                                      eventTypeColor: AppColors.foodColor,
                                    );
                                  }
                                  case SportEvent: {
                                    calendarEvent as SportEvent;
                                    return EventItemList(
                                      title: calendarEvent.sportInfo,
                                      dateTime: calendarEvent.eventDate,
                                      onEdit: () => _dialogHelper.showAddSportDialog(
                                        context: context,
                                        onFinish: (text, eventDate, duration, onFinish) => bloc.add(
                                          EditCalendarSportEventAction(
                                            eventId: calendarEvent.eventId,
                                            sportInfo: text,
                                            eventDate: eventDate,
                                            duration: duration,
                                            onFinish: () {
                                              onFinish.call();
                                              bloc.add(SelectDayEventsActions(selectedDay: _selectedDay));
                                            },
                                          ),
                                        ),
                                        sportEvent: calendarEvent,
                                      ),
                                      onDelete: () => bloc.add(DeleteCalendarEventAction(calendarEvent: calendarEvent, onFinish: () => bloc.add(InitializeStateAction()))),
                                      eventTypeColor: AppColors.sportColor,
                                      duration: calendarEvent.duration,
                                    );
                                  }
                                  case SleepEvent: {
                                    calendarEvent as SleepEvent;
                                    return SleepEventItemList(
                                      eventDate: calendarEvent.eventDate,
                                      duration: calendarEvent.sleepTime,
                                      quality: calendarEvent.quality,
                                      onEdit: () => _dialogHelper.showAddSleepDialog(
                                        context: context,
                                        onFinish: (quality, sleepTime, eventDate, onCloseDialog) => bloc.add(
                                          EditCalendarSleepEventAction(
                                            eventId: calendarEvent.eventId,
                                            quality: quality,
                                            sleepTime: sleepTime,
                                            eventDate: eventDate,
                                            onFinish: () {
                                              onCloseDialog.call();
                                              bloc.add(SelectDayEventsActions(selectedDay: _selectedDay));
                                            },
                                          ),
                                        ),
                                        sleepEvent: calendarEvent,
                                      ),
                                      onDelete: () => bloc.add(DeleteCalendarEventAction(calendarEvent: calendarEvent, onFinish: () => bloc.add(InitializeStateAction()))),
                                    );
                                  }
                                  case PoopEvent: {
                                    calendarEvent as PoopEvent;
                                    return PoopEventItemList(
                                      eventDate: calendarEvent.eventDate,
                                      poopType: calendarEvent.poopType,
                                      abdominalPain: calendarEvent.abdominalPain,
                                      flatulence: calendarEvent.flatulence,
                                      onEdit: () =>
                                          _dialogHelper.showAddPoopDialog(
                                            context: context,
                                            onFinish: (poopType, abdominalPain, flatulence, eventDate, onCloseDialog,) =>
                                                bloc.add(
                                                  EditCalendarPoopEventAction(
                                                    eventId: calendarEvent.eventId,
                                                    poopType: poopType,
                                                    abdominalPain: abdominalPain,
                                                    flatulence: flatulence,
                                                    eventDate: eventDate,
                                                    onFinish: () {
                                                      onCloseDialog.call();
                                                      bloc.add(SelectDayEventsActions(selectedDay: _selectedDay));
                                                    },
                                                  ),
                                                ),
                                            poopEvent: calendarEvent,
                                          ),
                                      onDelete: () => bloc.add(DeleteCalendarEventAction(calendarEvent: calendarEvent, onFinish: () => bloc.add(InitializeStateAction()))),
                                    );
                                  }
                                  case SupplementEvent: {
                                    calendarEvent as SupplementEvent;
                                    return SupplementEventListItem(
                                      isCalendar: true,
                                      supplementEvent: calendarEvent,
                                      onEditSupplementEvent: () {},
                                      onDeleteSupplementEvent: () => bloc.add(DeleteCalendarEventAction(calendarEvent: calendarEvent, onFinish: () => bloc.add(InitializeStateAction()))),
                                    );
                                  }
                                  case AnsweredQuestionnaire: {
                                    calendarEvent as AnsweredQuestionnaire;
                                    return QuestionnaireListItem(
                                      questionnaire: calendarEvent,
                                      onEyeClick: () => _dialogHelper.showQuestionnaireDialog(
                                        context: context,
                                        questionnaire: calendarEvent,
                                        onFinish: () => Navigator.pop(context),
                                      ),
                                    );
                                  }
                                  default: return Container();
                                }
                              })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}