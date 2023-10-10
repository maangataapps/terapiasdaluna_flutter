import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/helpers/dialog_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/image_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/supplements/bloc/supplements_actions.dart';
import 'package:terapiasdaluna/presentation/supplements/bloc/supplements_bloc.dart';
import 'package:terapiasdaluna/presentation/supplements/bloc/supplements_state.dart';
import 'package:terapiasdaluna/presentation/widgets/no_events_card.dart';
import 'package:terapiasdaluna/presentation/widgets/supplement_event_list_item.dart';
import 'package:terapiasdaluna/presentation/widgets/supplement_list_item.dart';
import 'package:terapiasdaluna/presentation/widgets/top_label.dart';

class SupplementsScreen extends StatefulWidget {
  static const routeName = '/supplements';

  const SupplementsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SupplementsScreenState();
}

class _SupplementsScreenState extends State<SupplementsScreen> {
  final _dialogHelper = DialogHelper();

  @override
  void initState() {
    final bloc = BlocProvider.of<SupplementsBloc>(context);
    bloc.add(InitializeStateAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SupplementsBloc>(context);

    return BlocProvider.value(
      value: bloc,
      child: SafeArea(
        child: BlocConsumer<SupplementsBloc, SupplementsState>(
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
            return StreamBuilder<List<Supplement>>(
              stream: bloc.streamStream,
              builder: (ctx, snapshot) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.supplementsColor,
                    title: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            AppLocalizations.of(context)!.supplements,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () =>
                                _dialogHelper.showSupplementsListDialog(
                                  context: context,
                                  supplementList: snapshot.data ?? [],
                                  onClickSupplement: (bool value, Supplement supplement) => bloc.add(ChangeSupplementActivationStateAction(
                                    isActivated: value,
                                    supplement: supplement,
                                  ),),
                                  onFinish: () {},
                                ),
                            icon: Image.asset(
                              ImageHelper().supplementImage,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () =>
                                _dialogHelper.showAddSupplementDialog(
                                  context: ctx,
                                  onFinish: (Supplement supplement, Function onFinish) =>
                                      bloc.add(SaveSupplementAction(
                                        supplement: supplement,
                                        onFinish: onFinish,
                                      ),),
                                ),
                            icon: const Icon(
                              Icons.add_circle, color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: Dimens.marginLarge),
                              child: SingleChildScrollView(
                                child: snapshot.data != null && snapshot.data!.isNotEmpty && snapshot.data!.any((supplement) => supplement.isActivated)
                                    ? Column(
                                  children: [
                                    ...snapshot.data!
                                        .where((supplement) => supplement.isActivated)
                                        .map((supplement) => SupplementListItem(
                                      supplement: supplement,
                                      onEdit: () =>
                                          _dialogHelper.showAddSupplementDialog(
                                            context: context,
                                            supplement: supplement,
                                            onFinish: (Supplement editedSupplement, Function onFinish,) =>
                                                bloc.add(EditSupplementAction(
                                                  supplement: editedSupplement,
                                                  onFinish: onFinish,
                                                ),),
                                          ),
                                      onDelete: () => {},
                                    ),).toList()
                                  ],
                                )
                                    : NoEventsCard(color: AppColors.supplementsColor, message: AppLocalizations.of(context)!.no_supplements_message),
                              ),
                            ),
                            TopLabel(
                              backgroundColor: AppColors.supplementsColor,
                              textColor: Colors.white,
                              label: AppLocalizations.of(context)!.supplements,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: AppColors.supplementsColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: StreamBuilder<List<SupplementEvent>>(
                            stream: bloc.streamEventsStream,
                            builder: (ctx, snapshotEvents) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: Dimens.marginXXLarge),
                                    child: SingleChildScrollView(
                                      child: snapshotEvents.data != null && snapshotEvents.data!.isNotEmpty
                                          ? Column(
                                        children: [
                                          ...snapshotEvents.data!.map((supplementEvent) => SupplementEventListItem(
                                            supplementEvent: supplementEvent,
                                            onEditSupplementEvent: () => _dialogHelper.showAddSupplementEventDialog(
                                              context: context,
                                              supplementEvent: supplementEvent,
                                              supplementList: snapshot.data!.toList().where((supplement) => supplement.isActivated).toList(),
                                              onFinish: (Supplement supplement, DateTime chosenDate, String? eventId) => bloc.add(EditSupplementEventAction(
                                                supplement: supplement,
                                                chosenDate: chosenDate,
                                                eventId: eventId,
                                                onFinish: () => Navigator.pop(context),
                                              ),),
                                            ),
                                            onDeleteSupplementEvent: () => bloc.add(DeleteSupplementEventAction(supplementEvent: supplementEvent)),
                                          ),).toList()
                                        ],
                                      )
                                          : NoEventsCard(color: AppColors.supplementsColor, message: AppLocalizations.of(context)!.no_events_message),
                                    ),
                                  ),
                                  TopLabel(
                                    backgroundColor: AppColors.supplementsColor,
                                    textColor: Colors.white,
                                    label: AppLocalizations.of(context)!.taken_supplements_label,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginNormal),
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          backgroundColor: AppColors.supplementsColor,
                          child: const Icon(Icons.add),
                          onPressed: () =>
                              _dialogHelper.showAddSupplementEventDialog(
                                context: context,
                                supplementList: snapshot.data!.toList().where((supplement) => supplement.isActivated).toList(),
                                onFinish: (Supplement supplement, DateTime chosenDate, String? eventId) => bloc.add(SaveSupplementEventAction(
                                  supplement: supplement,
                                  chosenDate: chosenDate,
                                  onFinish: () => Navigator.pop(context),
                                ),),
                              ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

}