import 'package:surf_practice_chat_flutter/core/widgets/avatar/model_with_initials.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

/// Basic model, representing chat user.
class ChatUserDto with ModelWithInitials {
  final int id;

  /// User's name.
  final String name;

  @override
  String get fullName => name;

  /// Constructor for [ChatUserDto].
  const ChatUserDto({
    required this.id,
    required String? name,
  }) : name = name ?? 'Неизвестный';

  /// Factory-like constructor for converting DTO from [StudyJamClient].
  ChatUserDto.fromSJClient(SjUserDto sjUserDto)
      : this(id: sjUserDto.id, name: sjUserDto.username);

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
