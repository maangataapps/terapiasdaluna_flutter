import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/helpers/dialog_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/sleepevents/bloc/sleep_events_actions.dart';
import 'package:terapiasdaluna/presentation/sleepevents/bloc/sleep_events_bloc.dart';
import 'package:terapiasdaluna/presentation/sleepevents/bloc/sleep_events_state.dart';
import 'package:terapiasdaluna/presentation/widgets/no_events_card.dart';
import 'package:terapiasdaluna/presentation/widgets/sleep_event_item_list.dart';

class SleepEventsScreen extends StatefulWidget {
  static const routeName = '/sleep_events';

  const SleepEventsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SleepEventsScreenState();

}

class _SleepEventsScreenState extends State<SleepEventsScreen> {
  final _dialogHelper = DialogHelper();

  @override
  void initState() {
    final bloc = BlocProvider.of<SleepEventsBloc>(context);
    bloc.add(InitializeStateAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SleepEventsBloc>(context);

    return BlocProvider.value(
      value: bloc,
      child: SafeArea(
        child: BlocConsumer<SleepEventsBloc, SleepEventsState>(
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
                backgroundColor: AppColors.sleepColor,
                title: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        AppLocalizations.of(context)!.sleep_events,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => _dialogHelper.showAddSleepDialog(
                          context: ctx,
                          onFinish: (int quality, int sleepTime, int eventDate, onCloseDialog) => bloc.add(
                            SaveSleepEventAction(
                              quality: quality,
                              sleepTime: sleepTime,
                              eventDate: eventDate,
                              onFinish: () => onCloseDialog.call(),
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.add_circle, color: Colors.white,),
                      ),
                    )
                  ],
                ),
              ),
              body: StreamBuilder<List<SleepEvent>>(
                stream: bloc.streamStream,
                builder: (ctx, snapshot) {
                  return SingleChildScrollView(
                    child: snapshot.data != null && snapshot.data!.isNotEmpty
                        ? Column(
                      children: [
                        ...snapshot.data!.map((sleepEvent) => SleepEventItemList(
                          eventDate: sleepEvent.eventDate,
                          duration: sleepEvent.sleepTime,
                          quality: sleepEvent.quality,
                          onEdit: () => _dialogHelper.showAddSleepDialog(
                            context: context,
                            onFinish: (quality, sleepTime, eventDate, onCloseDialog) => bloc.add(
                              EditSleepEventAction(
                                eventId: sleepEvent.eventId,
                                quality: quality,
                                sleepTime: sleepTime,
                                eventDate: eventDate,
                                onFinish: () => onCloseDialog.call(),
                              ),
                            ),
                            sleepEvent: sleepEvent,
                          ),
                          onDelete: () => bloc.add(DeleteSleepEventAction(sleepEvent: sleepEvent)),
                        ),).toList()
                      ],
                    )
                        : NoEventsCard(color: AppColors.sleepColor, message: AppLocalizations.of(context)!.no_events_message),
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

