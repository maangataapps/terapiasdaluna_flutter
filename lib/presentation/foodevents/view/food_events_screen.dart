import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/helpers/dialog_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/foodevents/bloc/food_events_actions.dart';
import 'package:terapiasdaluna/presentation/foodevents/bloc/food_events_bloc.dart';
import 'package:terapiasdaluna/presentation/foodevents/bloc/food_events_state.dart';
import 'package:terapiasdaluna/presentation/widgets/event_item_list.dart';
import 'package:terapiasdaluna/presentation/widgets/no_events_card.dart';

class FoodEventsScreen extends StatefulWidget {
  static const routeName = '/food_events';
  const FoodEventsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FoodEventsScreenState();

}

class _FoodEventsScreenState extends State<FoodEventsScreen> {
  final _dialogHelper = DialogHelper();

  @override
  void initState() {
    final bloc = BlocProvider.of<FoodEventsBloc>(context);
    bloc.add(InitializeStateAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FoodEventsBloc>(context);
    
    return BlocProvider.value(
      value: bloc,
      child: SafeArea(
        child: BlocConsumer<FoodEventsBloc, FoodEventsState>(
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
                backgroundColor: AppColors.foodColor,
                title: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        AppLocalizations.of(context)!.food_events,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => _dialogHelper.showAddFoodDialog(
                          context: ctx,
                          onFinish: (text, eventDate, onFinish) => bloc.add(
                            SaveFoodEventAction(
                              foodInfo: text,
                              eventDate: eventDate,
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
              body: StreamBuilder<List<FoodEvent>>(
                stream: bloc.streamStream,
                builder: (ctx, snapshot) {
                  return SingleChildScrollView(
                    child: snapshot.data != null && snapshot.data!.isNotEmpty
                        ? Column(
                          children: [
                            ...snapshot.data!.map((foodEvent) => EventItemList(
                              title: foodEvent.foodInfo,
                              dateTime: foodEvent.eventDate,
                              onEdit: () => _dialogHelper.showAddFoodDialog(
                                context: context,
                                onFinish: (text, eventDate, onFinish) => bloc.add(EditFoodEventAction(eventId: foodEvent.eventId, foodInfo: text, eventDate: eventDate, onFinish: onFinish,),),
                                foodEvent: foodEvent,
                              ),
                              onDelete: () => bloc.add(DeleteFoodEventAction(foodEvent: foodEvent)),
                              eventTypeColor: AppColors.foodColor,
                            ),).toList()
                          ],
                        )
                        : NoEventsCard(color: AppColors.foodColor, message: AppLocalizations.of(context)!.no_events_message),
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
