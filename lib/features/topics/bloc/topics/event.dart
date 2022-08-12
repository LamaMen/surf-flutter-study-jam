part of 'bloc.dart';

abstract class TopicsEvent {}

class GetMessagesEvent implements TopicsEvent {
  const GetMessagesEvent();
}