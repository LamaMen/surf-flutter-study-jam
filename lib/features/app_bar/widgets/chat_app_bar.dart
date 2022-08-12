import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  final VoidCallback onUpdatePressed;
  final Widget? leading;
  final String? title;

  const ChatAppBar({
    Key? key,
    required this.onUpdatePressed,
    this.leading,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title != null ? Text(title!) : null,
      actions: [
        IconButton(
          onPressed: onUpdatePressed,
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
