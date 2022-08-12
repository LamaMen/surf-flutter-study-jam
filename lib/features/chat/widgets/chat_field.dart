import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/chat/bloc/chat/bloc.dart';

class ChatTextField extends StatefulWidget {
  final ValueChanged<String> onSendPressed;

  const ChatTextField({
    required this.onSendPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
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
            IconButton(
              onPressed: () {
                const event = SendGeolocationMessageEvent();
                context.read<ChatBloc>().add(event);
              },
              icon: const Icon(Icons.add_location),
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
