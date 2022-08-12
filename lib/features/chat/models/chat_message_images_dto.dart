import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

class ChatMessageImagesDto extends ChatMessageDto {
  final List<String> images;

  ChatMessageImagesDto({
    required super.chatUserDto,
    required this.images,
    required super.message,
    required super.createdDateTime,
    required super.isLast,
  });

  ChatMessageImagesDto.fromSJClient({
    required SjMessageDto message,
    required ChatUserDto user,
    required super.isLast,
  })  : images = message.images!,
        super.fromSJClient(
          message: message,
          user: user,
        );

  @override
  bool get isValid => images.isNotEmpty;

  @override
  String toString() =>
      'ChatMessageImagesDto(images: $images) extends ${super.toString()}';
}
