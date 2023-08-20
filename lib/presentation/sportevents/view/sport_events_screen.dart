import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/helpers/dialog_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/sportevents/bloc/sport_events_actions.dart';
import 'package:terapiasdaluna/presentation/sportevents/bloc/sport_events_bloc.dart';
import 'package:terapiasdaluna/presentation/sportevents/bloc/sport_events_state.dart';
import 'package:terapiasdaluna/presentation/widgets/event_item_list.dart';
import 'package:terapiasdaluna/presentation/widgets/no_events_card.dart';

class SportEventsScreen extends StatefulWidget {
  static const routeName = '/sport_events';

  const SportEventsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SportEventsScreenState();
}

class _SportEventsScreenState extends State<SportEventsScreen> {
  final DialogHelper _dialogHelper = DialogHelper();

  @override
  void initState() {
    final bloc = BlocProvider.of<SportEventsBloc>(context);
    bloc.add(InitializeStateAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SportEventsBloc>(context);

    return BlocProvider.value(
      value: bloc,
      child: SafeArea(
        child: BlocConsumer<SportEventsBloc, SportEventsState>(
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
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.sportColor,
                title: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        AppLocalizations.of(context)!.sport_events,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => _dialogHelper.showAddSportDialog(
                          context: ctx,
                          onFinish: (text, eventDate, duration, onFinish) => bloc.add(
                            SaveSportEventAction(
                                sportInfo: text,
                                eventDate: eventDate,
                                duration: duration,
                                onFinish: onFinish,
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.add_circle, color: Colors.white,),
                      ),
                    )
                  ],
                ),
              ),
              body: StreamBuilder<List<SportEvent>>(
                stream: bloc.streamStream,
                builder: (ctx, snapshot) {
                  return SingleChildScrollView(
                    child: snapshot.data != null && snapshot.data!.isNotEmpty
                        ? Column(
                            children: [
                              ...snapshot.data!.map((sportEvent) => EventItemList(
                                title: sportEvent.sportInfo,
                                dateTime: sportEvent.eventDate,
                                onEdit: () => _dialogHelper.showAddSportDialog(
                                  context: context,
                                  onFinish: (text, eventDate, duration, onFinish) => bloc.add(
                                    EditSportEventAction(
                                      eventId: sportEvent.eventId,
                                      sportInfo: text,
                                      eventDate: eventDate,
                                      duration: duration,
                                      onFinish: onFinish,
                                    ),
                                  ),
                                  sportEvent: sportEvent,
                                ),
                                onDelete: () => bloc.add(DeleteSportEventAction(sportEvent: sportEvent)),
                                eventTypeColor: AppColors.sportColor,
                                duration: sportEvent.duration,
                              ),).toList()
                            ],
                          )
                        : NoEventsCard(color: AppColors.sportColor, message: AppLocalizations.of(context)!.no_events_message),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

}