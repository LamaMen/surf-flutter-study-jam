import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

/// Data transfer object representing geolocation chat message.
class ChatMessageGeolocationDto extends ChatMessageDto {
  /// Location point.
  final ChatGeolocationDto location;

  /// Constructor for [ChatMessageGeolocationDto].
  ChatMessageGeolocationDto({
    required super.chatUserDto,
    required this.location,
    required super.message,
    required super.createdDateTime,
    required super.isLast,
  });

  /// Named constructor for converting DTO from [StudyJamClient].
  ChatMessageGeolocationDto.fromSJClient({
    required SjMessageDto message,
    required ChatUserDto user,
    required super.isLast,
  })  : location = ChatGeolocationDto.fromGeoPoint(message.geopoint!),
        super.fromSJClient(
          message: message,
          user: user,
        );

  @override
  bool get isValid => location.isValid;

  @override
  String toString() =>
      'ChatMessageGeolocationDto(location: $location) extends ${super.toString()}';
}
