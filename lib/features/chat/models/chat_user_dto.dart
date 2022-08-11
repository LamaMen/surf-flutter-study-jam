import 'package:surf_study_jam/surf_study_jam.dart';

/// Basic model, representing chat user.
class ChatUserDto {
  final int id;

  /// User's name.
  final String name;

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

  String get initials {
    final byWords = name.split(' ').where((w) => w.isNotEmpty);
    if (byWords.length > 1) {
      return '${byWords.first[0]}${byWords.last[0]}'.toUpperCase();
    }

    return '${byWords.first[0]}${byWords.first[1]}'.toUpperCase();
  }
}
