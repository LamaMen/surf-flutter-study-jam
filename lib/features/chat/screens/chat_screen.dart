import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/app_bar/widgets/chat_app_bar.dart';
import 'package:surf_practice_chat_flutter/features/chat/bloc/chat/bloc.dart';
import 'package:surf_practice_chat_flutter/features/chat/bloc/title/bloc.dart';
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
      child: BlocBuilder<ChatTitleBloc, ChatTitleState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: colorScheme.background,
            appBar: ChatAppBar(
              onUpdatePressed: _update,
              title: state.title,
              subtitle: state.subtitle,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(child: _ChatBody()),
                ChatTextField(onSendPressed: _onSendPressed),
              ],
            ),
          );
        },
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
  const _ChatBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final messages = state.messages;
        final count = messages.length;

        return ListView.builder(
          itemCount: count,
          reverse: true,
          itemBuilder: (_, index) => ChatMessage(
            chatData: messages.elementAt(count - (index + 1)),
          ),
        );
      },
    );
  }
}
