// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/helpers/dialog_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/admin/view/admin_screen.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/dashboard/view/dashboard_screen.dart';
import 'package:terapiasdaluna/presentation/login/bloc/login_actions.dart';
import 'package:terapiasdaluna/presentation/login/bloc/login_bloc.dart';
import 'package:terapiasdaluna/presentation/login/bloc/login_state.dart';
import 'package:terapiasdaluna/presentation/registry/view/registry_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final bloc = BlocProvider.of<LoginBloc>(context);
    bloc.add(InitializeStateAction());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    final dialogHelper = DialogHelper();

    return BlocProvider.value(
      value: bloc,
      child: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
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
          builder: (cxt, state) => SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(Dimens.marginXLarge),
                        child: Image.asset(
                          'assets/icons/logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (!state.isLogin!) Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.username_hint,
                            errorMaxLines: 3,
                          ),
                          controller: _usernameController,
                          validator: (value) => resolveFormError(context, bloc.validateUsername(value)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText:
                            AppLocalizations.of(context)!.email,
                            errorMaxLines: 3,
                          ),
                          controller: _emailController,
                          validator: (value) => resolveFormError(context, bloc.validateEmail(value)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.password_hint,
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.isPasswordVisible! ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () => bloc.add(ChangePasswordVisibility()),
                            ),
                            errorMaxLines: 3,
                          ),
                          controller: _passwordController,
                          obscureText: state.isPasswordVisible!,
                          validator: (value) => resolveFormError(context, bloc.validatePassword(value)),
                        ),
                      ),
                      if (!state.isLogin!) Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.repeat_password,
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.isRepeatPasswordVisible! ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () => bloc.add(ChangeRepeatPasswordVisibility()),
                            ),
                            errorMaxLines: 3,
                          ),
                          controller: _repeatPasswordController,
                          obscureText: state.isRepeatPasswordVisible!,
                          validator: (value) => resolveFormError(context, bloc.validateRepeatPassword(value, _passwordController.text)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: Dimens.marginXXLarge),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                            ),
                            child: Text(state.isLogin!
                                ? AppLocalizations.of(context)!.login
                                : AppLocalizations.of(context)!.register,
                            ),
                            onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (state.isLogin!) {
                                    bloc.add(DoLoginAction(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      onFinish: (int userType) {
                                        if (userType == UserType.user.index) {
                                          Navigator.of(context).popAndPushNamed(DashboardScreen.routeName);
                                        } else if (userType == UserType.admin.index) {
                                          Navigator.of(context).popAndPushNamed(AdminScreen.routeName);
                                        }
                                      },
                                    ),);
                                  } else {
                                    if (_passwordController.text == _repeatPasswordController.text) {
                                      dialogHelper.showTermsAndConditionsDialog(
                                        context,
                                        onAccept: () {
                                          Navigator.pop(context);
                                          bloc.add(CreateUserAction(
                                            name: _usernameController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            acceptanceString: AppLocalizations.of(context)!.accept_terms_and_conditions,
                                            onFinish: () => Navigator.of(context).popAndPushNamed(RegistryScreen.routeName),
                                          ),);
                                        },
                                        onReject: () => Navigator.pop(context),
                                      );
                                    } else {
                                      showSnackBarError(context, AppLocalizations.of(context)!.passwords_dont_match);
                                    }
                                  }
                                }
                              },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                AppLocalizations.of(context)!.dont_have_account,
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(),
                              ),
                              onPressed: () => bloc.add(ChangeLoginModeAction()),
                              child: Text(
                                AppLocalizations.of(context)!.register,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(),
                              foregroundColor: Colors.teal,
                            ),
                            onPressed: () => dialogHelper.showForgottenPasswordDialog(
                              context,
                              onAccept: (String email) => bloc.add(ForgottenPasswordAction(email: email, onFinish: () => Navigator.pop(context))),
                              onReject: () => Navigator.pop(context),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.forgotten_password,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
