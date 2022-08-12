import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/features/app_bar/widgets/chat_app_bar.dart';
import 'package:surf_practice_chat_flutter/features/chat/widgets/image_view.dart';

class ImagesScreen extends StatelessWidget {
  static const route = '/images';
  final List<String> images;

  const ImagesScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(
        title: 'Изображения',
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: ImageView(image: images[index]),
            );
          },
        ),
      ),
    );
  }
}
