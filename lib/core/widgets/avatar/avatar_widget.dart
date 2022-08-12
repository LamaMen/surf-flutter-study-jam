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
    if (model.avatar != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(model.avatar!),
      );
    }
    final colorIndex = model.hashCode % colors.length;
    final color = colors[colorIndex];
    final textColor =
        color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return CircleAvatar(
      backgroundColor: color,
      child: Text(model.initials, style: TextStyle(color: textColor)),
    );
  }
}
