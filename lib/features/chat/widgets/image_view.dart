import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String image;
  final double? height;

  const ImageView({super.key, required this.image, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        image,
        height: height,
        fit: BoxFit.fill,
        errorBuilder: (context, _, __) {
          return const Image(image: AssetImage('assets/placeholder.jpeg'));
        },
      ),
    );
  }
}
