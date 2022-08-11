import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/core/client/login_client.dart';
import 'package:surf_practice_chat_flutter/features/chat/exceptions/invalid_message_exception.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_location_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_local_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

const int batchSize = 10000;

/// Basic interface of chat features.
///
/// The only tool needed to implement the chat.
abstract class IChatRepository {
  /// Maximum length of one's message content,
  static const int maxMessageLength = 80;

  Future<List<SjMessageDto>> getMessages();

  /// Sends the message by with [message] content.
  ///
  /// Returns actual messages [ChatMessageDto] from a source (given your sent
  /// [message]).
  ///
  ///
  /// [message] mustn't be empty and longer than [maxMessageLength]. Throws an
  /// [InvalidMessageException].
  Future<void> sendMessage(String message);

  /// Sends the message by [location] contents. [message] is optional.
  ///
  /// Returns actual messages [ChatMessageDto] from a source (given your sent
  /// [message]). Message with location point returns as
  /// [ChatMessageGeolocationDto].
  ///
  /// Throws an [Exception] when some error appears.
  ///
  ///
  /// If [message] is non-null, content mustn't be empty and longer than
  /// [maxMessageLength]. Throws an [InvalidMessageException].
  Future<void> sendGeolocationMessage({
    required ChatGeolocationDto location,
    String? message,
  });

  Future<List<ChatUserDto>> getUsers(List<int> ids);
}

/// Simple implementation of [IChatRepository], using [StudyJamClient].
@Singleton(as: IChatRepository)
class ChatRepository implements IChatRepository {
  final Client _client;

  /// Constructor for [ChatRepository].
  ChatRepository(this._client);

  @override
  Future<List<SjMessageDto>> getMessages() async {
    final messages = <SjMessageDto>[];

    var isLimitBroken = false;
    var lastMessageId = 0;

    // Chat is loaded in a 10 000 messages batches. It takes several batches to
    // load chat completely, especially if there's a lot of messages. Due to
    // API-request limitations, we can't load everything at one request, so
    // we're doing it in cycle.
    while (!isLimitBroken) {
      final batch = await _client.getMessages(
        lastMessageId: lastMessageId,
        limit: batchSize,
      );

      messages.addAll(batch);
      lastMessageId = batch.last.chatId;
      if (batch.length < batchSize) {
        isLimitBroken = true;
      }
    }

    return messages;
  }

  @override
  Future<void> sendMessage(String message) {
    return _send(message: message);
  }

  @override
  Future<void> sendGeolocationMessage({
    required ChatGeolocationDto location,
    String? message,
  }) {
    return _send(location: location, message: message);
  }

  Future<void> _send({
    ChatGeolocationDto? location,
    String? message,
  }) async {
    if (message != null && message.length > IChatRepository.maxMessageLength) {
      throw InvalidMessageException('Message "$message" is too large.');
    }

    await _client.sendMessage(SjMessageSendsDto(
      text: message,
      geopoint: location?.toGeopoint(),
    ));
  }

  @override
  Future<List<ChatUserDto>> getUsers(List<int> ids) async {
    final users = await _client.getUsers(ids);
    final localUser = await _client.getUser();

    return users
        .map((u) => localUser?.id == u.id
            ? ChatUserLocalDto.fromSJClient(u)
            : ChatUserDto.fromSJClient(u))
        .toList();
  }
}
