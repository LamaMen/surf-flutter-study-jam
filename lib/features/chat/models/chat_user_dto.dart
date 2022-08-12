import 'package:surf_practice_chat_flutter/core/widgets/avatar/model_with_initials.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

/// Basic model, representing chat user.
class ChatUserDto with ModelWithAvatar {
  final int id;

  /// User's name.
  @override
  final String name;

  @override
  final String? avatar;

  /// Constructor for [ChatUserDto].
  const ChatUserDto({
    required this.id,
    required String? name,
    this.avatar,
  }) : name = name ?? 'Неизвестный';

  /// Factory-like constructor for converting DTO from [StudyJamClient].
  ChatUserDto.fromSJClient(SjUserDto sjUserDto)
      : this(
          id: sjUserDto.id,
          name: sjUserDto.username,
          avatar: sjUserDto.avatar,
        );

  @override
  String toString() => 'ChatUserDto(name: $name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatUserDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
