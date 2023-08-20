import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/helpers/dialog_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/poopevents/bloc/poop_events_actions.dart';
import 'package:terapiasdaluna/presentation/poopevents/bloc/poop_events_bloc.dart';
import 'package:terapiasdaluna/presentation/poopevents/bloc/poop_events_state.dart';
import 'package:terapiasdaluna/presentation/widgets/no_events_card.dart';
import 'package:terapiasdaluna/presentation/widgets/poop_event_item_list.dart';

class PoopEventsScreen extends StatefulWidget {
  static const routeName = '/poop_events';
  const PoopEventsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PoopEventsScreen();
}

class _PoopEventsScreen extends State<PoopEventsScreen> {
  final _dialogHelper = DialogHelper();

  @override
  void initState() {
    final bloc = BlocProvider.of<PoopEventsBloc>(context);
    bloc.add(InitializeStateAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PoopEventsBloc>(context);

    return BlocProvider.value(
      value: bloc,
      child: SafeArea(
        child: BlocConsumer<PoopEventsBloc, PoopEventsState>(
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
                backgroundColor: AppColors.poopColor,
                title: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        AppLocalizations.of(context)!.poop_events,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => _dialogHelper.showAddPoopDialog(
                          context: ctx,
                          onFinish: (int poopType, bool abdominalPain, bool flatulence, int eventDate, onCloseDialog) => bloc.add(
                            SavePoopEventAction(
                              poopType: poopType,
                              abdominalPain: abdominalPain,
                              flatulence: flatulence,
                              eventDate: eventDate,
                              onFinish: onCloseDialog,
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.add_circle, color: Colors.white,),
                      ),
                    )
                  ],
                ),
              ),
              body: StreamBuilder<List<PoopEvent>>(
                stream: bloc.streamStream,
                builder: (ctx, snapshot) {
                  return SingleChildScrollView(
                    child: snapshot.data != null && snapshot.data!.isNotEmpty
                        ? Column(
                      children: [
                        ...snapshot.data!.map((poopEvent) => PoopEventItemList(
                          eventDate: poopEvent.eventDate,
                          poopType: poopEvent.poopType,
                          abdominalPain: poopEvent.abdominalPain,
                          flatulence: poopEvent.flatulence,
                          onEdit: () => _dialogHelper.showAddPoopDialog(
                            context: context,
                            onFinish: (poopType, abdominalPain, flatulence, eventDate, onCloseDialog) => bloc.add(
                              EditPoopEventAction(
                                eventId: poopEvent.eventId,
                                poopType: poopType,
                                abdominalPain: abdominalPain,
                                flatulence: flatulence,
                                eventDate: eventDate,
                                onFinish: () => onCloseDialog.call(),
                              ),
                            ),
                            poopEvent: poopEvent,
                          ),
                          onDelete: () => bloc.add(DeletePoopEventAction(poopEvent: poopEvent)),
                        ),).toList()
                      ],
                    )
                        : NoEventsCard(color: AppColors.poopColor, message: AppLocalizations.of(context)!.no_events_message),
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