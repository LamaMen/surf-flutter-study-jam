part of 'bloc.dart';

abstract class TopicsEvent {}

class GetTopicsEvent implements TopicsEvent {
  const GetTopicsEvent();
}