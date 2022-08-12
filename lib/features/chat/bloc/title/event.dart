part of 'bloc.dart';

abstract class ChatTitleEvent {}

class GetTitleEvent implements ChatTitleEvent {
  const GetTitleEvent();
}
