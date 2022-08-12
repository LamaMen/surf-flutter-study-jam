part of 'bloc.dart';

class TopicsState {
  final Iterable<ChatTopicDto> topics;

  const TopicsState({required this.topics});

  const TopicsState.initial() : this(topics: const []);
}

class LoadingTopicsState extends TopicsState {
  LoadingTopicsState(TopicsState old) : super(topics: old.topics);
}

class FailedTopicsLoadState extends TopicsState {
  final String exception;

  FailedTopicsLoadState(TopicsState old, this.exception)
      : super(topics: old.topics);
}
