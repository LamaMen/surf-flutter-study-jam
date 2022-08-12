import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/core/result/result.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';

final creationWorldTime = DateTime(2000);

@singleton
class TopicsUseCase {
  final IChatTopicsRepository _topicsRepository;

  TopicsUseCase(this._topicsRepository);

  FutureResult<Iterable<ChatTopicDto>> getTopics() async {
    try {
      final topics = await _topicsRepository.getTopics(
        topicsStartDate: creationWorldTime,
      );

      return Ok(topics);
    } on Exception catch (e) {
      return Fail(e);
    }
  }
}
