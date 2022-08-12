import 'package:surf_practice_chat_flutter/core/widgets/avatar/model_with_initials.dart';
import 'package:surf_study_jam/surf_study_jam.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_send_dto.dart';

/// Data transfer object representing simple chat topic.
///
/// Is different from [ChatTopicSendDto], because it does contain id.
/// This topic has already been created in API.
class ChatTopicDto with ModelWithInitials {
  /// Topic's unique id.
  final int id;

  /// Topic's name.
  ///
  /// Should be less than 128 characters long.
  final String? name;

  /// Topic's description.
  ///
  /// Should be less than 1024 characters long.
  final String? description;

  @override
  String get fullName => name ?? 'Новый чат';

  /// Constructor for [ChatTopicDto].
  const ChatTopicDto({
    required this.id,
    this.name,
    this.description,
  });

  /// Named constructor for converting DTO from [StudyJamClient].
  ChatTopicDto.fromSJClient({
    required SjChatDto sjChatDto,
  })  : id = sjChatDto.id,
        name = sjChatDto.name,
        description = sjChatDto.description;

  @override
  String toString() =>
      'ChatTopicDto(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatTopicDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
