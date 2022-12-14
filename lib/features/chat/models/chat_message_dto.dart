import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_images_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_location_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

/// Data transfer object representing simple chat message.
class ChatMessageDto {
  /// Author of message.
  final ChatUserDto chatUserDto;

  /// Chat message string.
  final String? message;

  /// Creation date and time.
  final DateTime createdDateTime;

  final bool isLast;

  /// Constructor for [ChatMessageDto].
  const ChatMessageDto({
    required this.chatUserDto,
    required this.message,
    required this.createdDateTime,
    required this.isLast,
  });

  /// Named constructor for converting DTO from [StudyJamClient].
  ChatMessageDto.fromSJClient({
    required SjMessageDto message,
    required ChatUserDto user,
    required this.isLast,
  })  : chatUserDto = user,
        message = message.text,
        createdDateTime = message.created;

  factory ChatMessageDto.create({
    required SjMessageDto message,
    required ChatUserDto user,
    required bool isLast,
  }) {
    if (message.geopoint != null) {
      return ChatMessageGeolocationDto.fromSJClient(
        message: message,
        user: user,
        isLast: isLast,
      );
    }

    if (message.images != null) {
      return ChatMessageImagesDto.fromSJClient(
        message: message,
        user: user,
        isLast: isLast,
      );
    }

    return ChatMessageDto.fromSJClient(
      message: message,
      user: user,
      isLast: isLast,
    );
  }

  bool get isValid => message != null && message!.isNotEmpty;

  @override
  String toString() =>
      'ChatMessageDto(chatUserDto: $chatUserDto, message: $message, createdDate: $createdDateTime)';
}
