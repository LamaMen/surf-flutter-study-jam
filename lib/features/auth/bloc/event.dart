part of 'bloc.dart';

abstract class AuthEvent {}

class EnterDataEvent implements AuthEvent {
  final String login;
  final String password;

  const EnterDataEvent({
    required this.login,
    required this.password,
  });

  FormData get data => FormData(login, password);
}

class CheckUserDataEvent implements AuthEvent {
  const CheckUserDataEvent();
}
