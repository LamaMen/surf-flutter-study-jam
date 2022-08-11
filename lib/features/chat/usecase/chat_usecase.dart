import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/core/result/result.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_location_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';

@singleton
class ChatUseCase {
  final IChatRepository _chatRepository;

  ChatUseCase(this._chatRepository);

  FutureResult<Iterable<ChatMessageDto>> getMessages() async {
    try {
      final newMessages = await _fetchMessages();
      return Ok(newMessages);
    } on Exception catch (e) {
      return Fail(e);
    }
  }

  FutureResult<Iterable<ChatMessageDto>> sendMessage(String message) async {
    try {
      await _chatRepository.sendMessage(message);
      final newMessages = await _fetchMessages();
      return Ok(newMessages);
    } on Exception catch (e) {
      return Fail(e);
    }
  }

  Future<Iterable<ChatMessageDto>> _fetchMessages() async {
    final rawMessages = await _chatRepository.getMessages();
    final userIds = rawMessages.map((m) => m.userId).toSet().toList();
    final users = await _chatRepository.getUsers(userIds);

    final messages = <ChatMessageDto>[];
    for (var i = 0; i < rawMessages.length; i++) {
      final m = rawMessages[i];
      final user = users.firstWhere((userDto) => userDto.id == m.userId);
      late final bool isLast;

      if (i != (rawMessages.length - 1)) {
        final next = rawMessages[i + 1];
        isLast = m.userId != next.userId;
      } else {
        isLast = true;
      }

      messages.add(m.geopoint == null
          ? ChatMessageDto.fromSJClient(message: m, user: user, isLast: isLast)
          : ChatMessageGeolocationDto.fromSJClient(
              message: m,
              user: user,
              isLast: isLast,
            ));
    }

    final me = messages
        .where((m) =>
            (m is ChatMessageGeolocationDto && m.location.isValid) ||
            (m is! ChatMessageGeolocationDto &&
                m.message != null &&
                m.message!.isNotEmpty))
        .toList();

    return me;
  }
}
