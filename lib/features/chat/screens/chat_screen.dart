import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth_screen.dart';
import 'package:surf_practice_chat_flutter/features/chat/bloc/bloc.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
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
        if (state is LogoutChatState) {
          Navigator.pushReplacementNamed(context, AuthScreen.route);
        }

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
          child: _ChatAppBar(onUpdatePressed: _update),
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
            _ChatTextField(onSendPressed: _onSendPressed),
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

class _ChatTextField extends StatefulWidget {
  final ValueChanged<String> onSendPressed;

  const _ChatTextField({
    required this.onSendPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<_ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<_ChatTextField> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: mediaQuery.padding.bottom + 8,
          left: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Сообщение',
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                widget.onSendPressed(_textEditingController.text);
                _textEditingController.clear();
              },
              icon: const Icon(Icons.send),
              color: colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

class _ChatAppBar extends StatelessWidget {
  final VoidCallback onUpdatePressed;

  const _ChatAppBar({
    required this.onUpdatePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => _singOut(context),
        icon: const Icon(Icons.logout),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onUpdatePressed,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  void _singOut(BuildContext context) {
    const event = SingOutEvent();
    context.read<ChatBloc>().add(event);
  }
}
