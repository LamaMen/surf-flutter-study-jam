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

class _Avatar extends StatelessWidget {
  final ModelWithAvatar model;

  const _Avatar(this.model);

  @override
  Widget build(BuildContext context) {
    final colorIndex = model.hashCode % colors.length;
    final color = colors[colorIndex];
    final textColor =
        color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    final image = model.avatar != null ? NetworkImage(model.avatar!) : null;
    final child = model.avatar == null
        ? Text(model.initials, style: TextStyle(color: textColor))
        : null;

    return CircleAvatar(
      backgroundColor: color,
      backgroundImage: image,
      child: child,
    );
  }
}
