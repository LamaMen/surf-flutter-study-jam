part of 'bloc.dart';

class ChatState {
  final Iterable<ChatMessageDto> messages;

  const ChatState({
    required this.messages,
  });

  const ChatState.initial() : this(messages: const []);
}

class LoadingChatState extends ChatState {
  LoadingChatState(ChatState old) : super(messages: old.messages);
}

class FailedChatState extends ChatState {
  final String exception;

  FailedChatState(ChatState old, this.exception)
      : super(messages: old.messages);
}

class LogoutChatState extends ChatState {
  LogoutChatState(ChatState old) : super(messages: old.messages);
}
