part of 'bloc.dart';

abstract class AuthState {}

class EnterDataState implements AuthState {
  const EnterDataState();
}

class CheckUserDataState implements AuthState {
  const CheckUserDataState();
}

class CheckFailedState implements AuthState {
  final Exception exception;

  const CheckFailedState(this.exception);
}

class CheckSucceededState implements AuthState {
  final TokenDto token;
  const CheckSucceededState(this.token);
}
