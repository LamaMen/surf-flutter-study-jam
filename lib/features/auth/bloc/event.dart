part of 'bloc.dart';

abstract class AuthEvent {}

class CheckUserDataEvent implements AuthEvent {
  final String login;
  final String password;

  const CheckUserDataEvent(this.login, this.password);
}
