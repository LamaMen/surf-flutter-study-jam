import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/core/widgets/avatar/model_with_initials.dart';

const colors = Colors.primaries;

class AvatarWidget extends StatelessWidget {
  final ModelWithAvatar model;
  final double? size;

  const AvatarWidget({
    Key? key,
    required this.model,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: _Avatar(model));
  }
}

class _Avatar extends StatefulWidget {
  final ModelWithAvatar model;

  const _Avatar(this.model);

  bool get isShowAvatar => model.avatar != null;

  String get avatar => model.avatar!;

  String get initials => model.initials;

  @override
  State<_Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<_Avatar> {
  bool isImageNotLoaded = false;

  @override
  Widget build(BuildContext context) {
    final colorIndex = widget.model.hashCode % colors.length;
    final color = colors[colorIndex];
    final textColor =
        color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    final image = widget.isShowAvatar ? NetworkImage(widget.avatar) : null;
    final initials = Text(widget.initials, style: TextStyle(color: textColor));

    return CircleAvatar(
      backgroundColor: color,
      backgroundImage: image,
      onBackgroundImageError: widget.model.avatar != null ? onError : null,
      child: !widget.isShowAvatar || isImageNotLoaded ? initials : null,
    );
  }

  void onError(Object exception, StackTrace? stackTrace) {
    setState(() => isImageNotLoaded = true);
  }
}
