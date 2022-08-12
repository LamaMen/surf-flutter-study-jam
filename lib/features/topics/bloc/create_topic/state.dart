part of 'bloc.dart';

class CreateTopicState {
  final ChatTopicSendDto chat;

  bool get isReady => chat.name != null && chat.name!.isNotEmpty;

  const CreateTopicState._({
    required this.chat,
  });

  const CreateTopicState.initial()
      : this._(chat: const ChatTopicSendDto.empty());

  CreateTopicState update(ChatTopicSendDto chat) {
    return CreateTopicState._(chat: chat);
  }
}

class SavingTopicState extends CreateTopicState {
  SavingTopicState(CreateTopicState old) : super._(chat: old.chat);
}

class CreationFailedState extends CreateTopicState {
  final String exception;

  CreationFailedState(CreateTopicState old, this.exception)
      : super._(chat: old.chat);
}

class TopicSavedState extends CreateTopicState {
  TopicSavedState(CreateTopicState old) : super._(chat: old.chat);
}
