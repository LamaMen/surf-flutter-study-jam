import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:surf_practice_chat_flutter/core/utils/date_utils.dart';
import 'package:surf_practice_chat_flutter/core/utils/list_utils.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_location_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_local_dto.dart';

class ChatMessage extends StatelessWidget {
  final ChatMessageDto chatData;

  const ChatMessage({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    if (chatData is ChatMessageGeolocationDto) {
      final data = chatData as ChatMessageGeolocationDto;
      return _Message(
        user: chatData.chatUserDto,
        time: chatData.createdDateTime,
        message: chatData.message,
        isLast: chatData.isLast,
        content: _LocationContent(location: data.location),
      );
    }

    return _Message(
      user: chatData.chatUserDto,
      time: chatData.createdDateTime,
      message: chatData.message,
      isLast: chatData.isLast,
    );
  }
}

class _Message extends StatelessWidget {
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
          _ChatAvatar(user: user, isShow: isLast),
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
                    if (content != null) ...[content!],
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

class _ChatAvatar extends StatelessWidget {
  static const double _size = 32;

  final ChatUserDto user;
  final bool isShow;

  const _ChatAvatar({
    Key? key,
    required this.user,
    required this.isShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (!isShow) {
      return const SizedBox(width: _size, height: _size);
    }

    return SizedBox(
      width: _size,
      height: _size,
      child: Material(
        color: colorScheme.primary,
        shape: const CircleBorder(),
        child: Center(
          child: Text(
            user.initials,
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
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
      child: FlutterMap(
        options: MapOptions(
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
    );
  }
}
