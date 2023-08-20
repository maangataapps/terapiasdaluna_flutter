class LoginActions {
  LoginActions();
}

class InitializeStateAction extends LoginActions {
  InitializeStateAction();
}

class CreateUserAction extends LoginActions {
  final String name;
  final String email;
  final String password;
  final String acceptanceString;
  final Function onFinish;

  CreateUserAction({required this.name, required this.email, required this.password, required this.acceptanceString, required this.onFinish});
}

class ChangePasswordVisibility extends LoginActions {
  ChangePasswordVisibility();
}

class ChangeRepeatPasswordVisibility extends LoginActions {
  ChangeRepeatPasswordVisibility();
}

class ChangeLoginModeAction extends LoginActions {
  ChangeLoginModeAction();
}

class DoLoginAction extends LoginActions {
  final String email;
  final String password;
  final Function onFinish;

  DoLoginAction({required this.email, required this.password, required this.onFinish});
}

class ForgottenPasswordAction extends LoginActions {
  final String email;
  final Function onFinish;

  ForgottenPasswordAction({required this.email, required this.onFinish});
}