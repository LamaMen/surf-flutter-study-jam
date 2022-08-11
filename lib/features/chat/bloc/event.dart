part of 'bloc.dart';

abstract class ChatEvent {}

class GetMessagesEvent implements ChatEvent {
  const GetMessagesEvent();
}

class SingOutEvent implements ChatEvent {
  const SingOutEvent();
}

class SendMessageEvent implements ChatEvent {
  final String message;

  const SendMessageEvent(this.message);
}
