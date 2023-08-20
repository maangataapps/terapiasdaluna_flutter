import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/extensions/extensions.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_picker_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/constants.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/dashboard/view/dashboard_screen.dart';
import 'package:terapiasdaluna/presentation/registry/bloc/registry_bloc.dart';
import 'package:terapiasdaluna/presentation/registry/bloc/registry_actions.dart';
import 'package:terapiasdaluna/presentation/registry/bloc/registry_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/presentation/widgets/centered_icon_box.dart';

class RegistryScreen extends StatefulWidget {
  static const routeName = '/registry';

  const RegistryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {

  @override
  void initState() {
    final bloc = BlocProvider.of<RegistryBloc>(context);
    bloc.add(InitializeStateAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RegistryBloc>(context);
    return BlocProvider.value(
      value: bloc,
      child: SafeArea(
        child: BlocConsumer<RegistryBloc, RegistryState>(
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
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(Dimens.marginXLarge),
                      child: Image.asset(
                        'assets/icons/logo.png',
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(Dimens.marginXLarge),
                      child: Text(
                        '${AppLocalizations.of(context)!.welcome_chunk} ${state.profileModel!.name.orEmpty()}!',
                        style: const TextStyle(
                          fontSize: Dimens.fontSizeLarge*2,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: Dimens.marginNormal,),
                              child: Text(
                                AppLocalizations.of(context)!.birthdate_question,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                DatePickerHelper.presentDatePicker(
                                  context: ctx,
                                  saveDate: (DateTime pickedDate) => bloc.add(SetBirthdateAction(birthdate: pickedDate)),
                                );
                              },
                              icon: const Icon(Icons.calendar_month, color: Colors.teal,),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(left: Dimens.marginLarge),
                          child: Text(
                            state.profileModel!.birthDate == -1
                                ? ''
                                : DateTimeHelper().formatDayMonthYearDate(state.profileModel!.birthDate),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: Dimens.marginLarge, left: Dimens.marginNormal),
                      child: Text(
                        AppLocalizations.of(context)!.sex_question,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: Dimens.marginNormal, top: Dimens.marginNormal),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: Dimens.marginNormal, right: Dimens.marginXSmall,),
                              child: CenteredIconBox(
                                colorSelected: Colors.teal,
                                icon: Icons.male,
                                onClick: () => bloc.add(SetSexAction(sexType: SexType.male)),
                                isSelected: state.profileModel!.sex == SexType.male.index,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(right: Dimens.marginNormal, left: Dimens.marginXSmall,),
                              child: CenteredIconBox(
                                colorSelected: Colors.teal,
                                icon: Icons.female,
                                onClick: () => bloc.add(SetSexAction(sexType: SexType.female)),
                                isSelected: state.profileModel!.sex == SexType.female.index,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: Dimens.marginLarge, left: Dimens.marginNormal),
                      child: Text(
                        AppLocalizations.of(context)!.height_question,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: Dimens.marginNormal),
                      child: NumberPicker(
                        minValue: Constants.HEIGHT_MIN,
                        maxValue: Constants.HEIGHT_MAX,
                        value: state.profileModel!.height != -1 ? state.profileModel!.height : Constants.HEIGHT_INITIAL_VALUE,
                        axis: Axis.horizontal,
                        step: 1,
                        textStyle: const TextStyle(
                          fontSize: Dimens.fontSizeNormal,
                          color: Colors.teal,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.teal),
                        ),
                        onChanged: (height) => bloc.add(SetHeightAction(height: height)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: Dimens.marginLarge, left: Dimens.marginNormal),
                      child: Text(
                        AppLocalizations.of(context)!.weight_question,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: Dimens.marginNormal, bottom: Dimens.marginXLarge),
                      child: NumberPicker(
                        minValue: Constants.WEIGHT_MIN,
                        maxValue: Constants.WEIGHT_MAX,
                        value: state.profileModel!.weight != -1 ? state.profileModel!.weight : Constants.WEIGHT_INITIAL_VALUE,
                        axis: Axis.horizontal,
                        step: 1,
                        textStyle: const TextStyle(
                          fontSize: Dimens.fontSizeNormal,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.teal),
                        ),
                        onChanged: (weight) => bloc.add(SetWeightAction(weight: weight)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(ctx).size.width/2,
                      child: ElevatedButton(
                        onPressed: () => bloc.add(SaveProfileAction(onFinish: () => Navigator.popAndPushNamed(context, DashboardScreen.routeName),),),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.teal),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.save,
                          style: const TextStyle(
                            color: Colors.white,
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