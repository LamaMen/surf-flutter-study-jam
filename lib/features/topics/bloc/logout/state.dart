part of 'bloc.dart';

class AppBarState {
  const AppBarState();
}

class LogoutState implements AppBarState {
  const LogoutState();
}

class FailedChatState implements AppBarState {
  final String message;

  const FailedChatState(this.message);
}
