import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/usecase/topics_usecase.dart';

part 'event.dart';
part 'state.dart';

@injectable
class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  final TopicsUseCase _topicsUsecase;

  TopicsBloc(
    this._topicsUsecase,
  ) : super(const TopicsState.initial()) {
    on<GetMessagesEvent>(onGetMessages);
  }

  Future<void> onGetMessages(
    GetMessagesEvent event,
    Emitter<TopicsState> emit,
  ) async {
    emit(LoadingTopicsState(state));
    final messages = await _topicsUsecase.getTopics();

    emit(messages.fold(
      (f) => FailedTopicsLoadState(state, f.toString()),
      (t) => TopicsState(topics: t),
    ));
  }
}
