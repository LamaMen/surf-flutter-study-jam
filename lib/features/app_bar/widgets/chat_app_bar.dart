import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onUpdatePressed;
  final Widget? leading;
  final String? title;
  final String? subtitle;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const ChatAppBar({
    Key? key,
    this.onUpdatePressed,
    this.leading,
    this.title,
    this.subtitle,
    double? height,
  })  : height = height ?? 48,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: _TitleWidget(
        title: title,
        subtitle: subtitle,
        height: height,
      ),
      actions: [
        if (onUpdatePressed != null) ...[
          IconButton(
            onPressed: onUpdatePressed,
            icon: const Icon(Icons.refresh),
          )
        ],
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final double height;

  const _TitleWidget({
    required this.title,
    required this.subtitle,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (title == null && subtitle == null) {
      return const SizedBox.shrink();
    }

    if (title != null) {
      if (subtitle != null) {
        return SizedBox(
          height: height,
          child: Column(
            children: [
              Text(title!),
              Text(
                subtitle!,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        );
      }

      return Text(title!);
    }

    return Text(subtitle!);
  }
}
