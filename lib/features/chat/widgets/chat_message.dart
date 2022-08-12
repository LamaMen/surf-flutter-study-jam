import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart' as launcher;
import 'package:surf_practice_chat_flutter/core/utils/date_utils.dart';
import 'package:surf_practice_chat_flutter/core/utils/list_utils.dart';
import 'package:surf_practice_chat_flutter/core/widgets/avatar/avatar_widget.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_images_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_location_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_local_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/images_screen.dart';
import 'package:surf_practice_chat_flutter/features/chat/widgets/image_view.dart';

class ChatMessage extends StatelessWidget {
  final ChatMessageDto chatData;

  const ChatMessage({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    Widget? content;

    if (chatData is ChatMessageGeolocationDto) {
      final data = chatData as ChatMessageGeolocationDto;
      content = _LocationContent(location: data.location);
    }

    if (chatData is ChatMessageImagesDto) {
      final data = chatData as ChatMessageImagesDto;
      content = _ImagesContent(images: data.images);
    }

    return _Message(
      user: chatData.chatUserDto,
      time: chatData.createdDateTime,
      message: chatData.message,
      isLast: chatData.isLast,
      content: content,
    );
  }
}

class _Message extends StatelessWidget {
  static const double _size = 32;
  final ChatUserDto user;
  final DateTime time;
  final String? message;
  final Widget? content;
  final bool isLast;

  const _Message({
    Key? key,
    required this.user,
    required this.time,
    required this.isLast,
    this.message,
    this.content,
  }) : super(key: key);

  bool get isSelf => user is ChatUserLocalDto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.up,
        children: [
          isLast
              ? AvatarWidget(model: user, size: _size)
              : const SizedBox(width: _size, height: _size),
          const SizedBox(width: 4),
          Expanded(
            flex: 4,
            child: Padding(
              padding: isLast
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.symmetric(horizontal: 6),
              child: Bubble(
                nip: _nip,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    if (message != null && message!.isNotEmpty) ...[
                      Text(message!)
                    ],
                    if (content != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: content!,
                      )
                    ],
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(time.formatted),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
        ].reversedByCondition(isSelf),
      ),
    );
  }

  BubbleNip get _nip {
    if (!isLast) return BubbleNip.no;
    return isSelf ? BubbleNip.rightBottom : BubbleNip.leftBottom;
  }
}

class _LocationContent extends StatelessWidget {
  final ChatGeolocationDto location;

  const _LocationContent({required this.location});

  @override
  Widget build(BuildContext context) {
    final marker = Marker(
      width: 10,
      height: 10,
      point: LatLng(location.latitude, location.longitude),
      builder: (ctx) => const Icon(Icons.location_on, color: Colors.redAccent),
    );

    return SizedBox(
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FlutterMap(
          options: MapOptions(
            onTap: (_, __) => _openMap(),
            center: marker.point,
            zoom: 12.5,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: [marker]),
          ],
        ),
      ),
    );
  }

  void _openMap() async {
    final availableMaps = await launcher.MapLauncher.installedMaps;

    await availableMaps.first.showMarker(
      coords: launcher.Coords(location.latitude, location.longitude),
      title: "User Location",
    );
  }
}

class _ImagesContent extends StatelessWidget {
  final List<String> images;

  const _ImagesContent({
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return ImageView(image: images.first, height: 150);
    }

    final otherCount = images.length - 1;
    const height = 75.0;
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(child: ImageView(image: images.first, height: height)),
          const SizedBox(width: 8),
          Expanded(
            child: otherCount == 1
                ? ImageView(image: images[1], height: height)
                : _OpenAllImagesButton(images: images, otherCount: otherCount),
          ),
        ],
      ),
    );
  }
}

class _OpenAllImagesButton extends StatelessWidget {
  final List<String> images;
  final int otherCount;

  const _OpenAllImagesButton({required this.images, required this.otherCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ImagesScreen.route, arguments: images);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            '+$otherCount',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
