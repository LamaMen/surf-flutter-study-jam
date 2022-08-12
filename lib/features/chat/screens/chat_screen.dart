import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/app_bar/widgets/chat_app_bar.dart';
import 'package:surf_practice_chat_flutter/features/chat/bloc/bloc.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/widgets/chat_field.dart';
import 'package:surf_practice_chat_flutter/features/chat/widgets/chat_message.dart';

/// Main screen of chat app, containing messages.
class ChatScreen extends StatefulWidget {
  static const route = '/chat';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    _update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is FailedChatState) {
          final snackBar = SnackBar(
            content: Text(state.exception),
            backgroundColor: Colors.red,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: ChatAppBar(onUpdatePressed: _update),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return _ChatBody(messages: state.messages);
                },
              ),
            ),
            ChatTextField(onSendPressed: _onSendPressed),
          ],
        ),
      ),
    );
  }

  void _update() {
    const event = GetMessagesEvent();
    context.read<ChatBloc>().add(event);
  }

  Future<void> _onSendPressed(String messageText) async {
    final event = SendMessageEvent(messageText);
    context.read<ChatBloc>().add(event);
  }
}

class _ChatBody extends StatelessWidget {
  final Iterable<ChatMessageDto> messages;

  const _ChatBody({
    required this.messages,
    Key? key,
  }) : super(key: key);

  int get count => messages.length;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      reverse: true,
      itemBuilder: (_, index) => ChatMessage(
        chatData: messages.elementAt(count - (index + 1)),
      ),
    );
  }
}
