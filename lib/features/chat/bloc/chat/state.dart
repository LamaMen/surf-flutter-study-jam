part of 'bloc.dart';

class ChatState {
  final Iterable<ChatMessageDto> messages;
  final int chatId;

  const ChatState._({
    required this.messages,
    required this.chatId,
  });

  const ChatState.initial(int id) : this._(messages: const [], chatId: id);

  ChatState copyWithMessages(Iterable<ChatMessageDto> messages) {
    return ChatState._(messages: messages, chatId: chatId);
  }
}

class LoadingChatState extends ChatState {
  LoadingChatState(ChatState old)
      : super._(messages: old.messages, chatId: old.chatId);
}

class FailedChatState extends ChatState {
  final String exception;

  FailedChatState(ChatState old, this.exception)
      : super._(messages: old.messages, chatId: old.chatId);
}
