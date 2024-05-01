
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {}
class LoginFailedState extends LoginState {
  final String errorMessage;
  LoginFailedState({required this.errorMessage});
}


