part of 'bloc.dart';

abstract class CreateTopicEvent {}

class EnterDataEvent implements CreateTopicEvent {
  final String name;
  final String description;

  const EnterDataEvent({
    required this.name,
    required this.description,
  });

  ChatTopicSendDto get chat =>
      ChatTopicSendDto(name: name, description: description);
}

class SaveEventEvent implements CreateTopicEvent {
  const SaveEventEvent();
}
