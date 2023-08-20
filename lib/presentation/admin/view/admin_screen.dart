import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/presentation/admin/bloc/admin_actions.dart';
import 'package:terapiasdaluna/presentation/admin/bloc/admin_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/presentation/admin/bloc/admin_state.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/dashboard/view/dashboard_screen.dart';
import 'package:terapiasdaluna/presentation/widgets/user_list_item.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = 'admin';

  const AdminScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AdminScreenState();

}

class _AdminScreenState extends State<AdminScreen> {

  @override
  void initState() {
    final bloc = BlocProvider.of<AdminBloc>(context);
    bloc.add(InitialiseStateAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AdminBloc>(context);

    return BlocProvider.value(
      value: bloc,
      child: SafeArea(
        child: BlocConsumer<AdminBloc, AdminState>(
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
            return StreamBuilder(
              stream: bloc.streamStream,
              builder: (ctx, snapshot) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.adminColor,
                    title: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            AppLocalizations.of(context)!.admin,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...state.users!.map((user) => UserListItem(
                          name: user.name,
                          sex: user.sex,
                          onClickUser: () => bloc.add(SelectUserAction(
                            user: user,
                            onFinish: () => Navigator.pushNamed(context, DashboardScreen.routeName),
                          ),),
                        ),).toList(),
                      ],
                    ),
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