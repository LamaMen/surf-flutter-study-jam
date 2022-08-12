import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/core/client/client.dart';
import 'package:surf_study_jam/surf_study_jam.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_send_dto.dart';

/// Basic interface for chat topics features.
///
/// The only tool needed to implement the chat topics.
abstract class IChatTopicsRepository {
  /// Gets all chat topics.
  ///
  /// Use [topicsStartDate] to specify from which moment, you
  /// would like to get topics. For example, if topic was made
  /// yesterday & you want to retrieve it, you should pass
  /// [DateTime.now].subtract(Duration(days:1))
  Future<Iterable<ChatTopicDto>> getTopics({
    required DateTime topicsStartDate,
  });

  /// Creates new chat topic.
  ///
  /// Retrieves [ChatTopicDto] with its unique id, once its
  /// created.
  Future<ChatTopicDto> createTopic(ChatTopicSendDto chatTopicSendDto);
}

/// Simple implementation of [IChatTopicsRepository], using [StudyJamClient].
@Singleton(as: IChatTopicsRepository)
class ChatTopicsRepository implements IChatTopicsRepository {
  final Client _client;

  /// Constructor for [ChatTopicsRepository].
  ChatTopicsRepository(this._client);

  @override
  Future<Iterable<ChatTopicDto>> getTopics({
    required DateTime topicsStartDate,
  }) async {
    final topicsIds = await _client.getChatsUpdates(topicsStartDate);
    if (topicsIds == null) return [];

    final topics = await _client.getChatsByIds(topicsIds);
    return topics.map((t) => ChatTopicDto.fromSJClient(sjChatDto: t));
  }

  @override
  Future<ChatTopicDto> createTopic(ChatTopicSendDto chatTopic) async {
    final sjChatDto = await _client.createChat(chatTopic.toSjChatSendsDto());
    return ChatTopicDto.fromSJClient(sjChatDto: sjChatDto);
  }
}
