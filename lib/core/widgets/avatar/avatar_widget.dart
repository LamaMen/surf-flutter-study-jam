import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/core/widgets/avatar/model_with_initials.dart';

const colors = Colors.primaries;

class AvatarWidget extends StatelessWidget {
  final ModelWithInitials model;
  final double? size;

  const AvatarWidget({
    Key? key,
    required this.model,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorIndex = model.hashCode % colors.length;
    final color = colors[colorIndex];
    final foregroundColor =
        color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: color,
        shape: const CircleBorder(),
        child: Center(
          child: Text(
            model.initials,
            style: TextStyle(
              color: foregroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
