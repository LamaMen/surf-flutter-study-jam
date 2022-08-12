part of 'bloc.dart';

class ChatTitleState {
  final ChatTopicDto chat;
  final ChatUserDto? user;

  String get title => chat.name;

  String? get subtitle => user?.name;

  const ChatTitleState._({required this.chat, required this.user});

  const ChatTitleState.initial(ChatTopicDto chat)
      : this._(chat: chat, user: null);

  ChatTitleState setUser(ChatUserDto? user) {
    return ChatTitleState._(chat: chat, user: user);
  }
}
