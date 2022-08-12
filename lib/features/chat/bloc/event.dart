part of 'bloc.dart';

abstract class ChatEvent {}

class GetMessagesEvent implements ChatEvent {
  const GetMessagesEvent();
}

class SendMessageEvent implements ChatEvent {
  final String message;

  const SendMessageEvent(this.message);
}

class SendGeolocationMessageEvent implements ChatEvent {
  const SendGeolocationMessageEvent();
}
