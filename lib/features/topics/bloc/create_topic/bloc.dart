import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_send_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/usecase/topics_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class CreateTopicBloc extends Bloc<CreateTopicEvent, CreateTopicState> {
  final TopicsUseCase _topicUseCase;

  CreateTopicBloc(
    this._topicUseCase,
  ) : super(const CreateTopicState.initial()) {
    on<EnterDataEvent>(onEnterData);
    on<SaveEventEvent>(onSave);
  }

  Future<void> onEnterData(
    EnterDataEvent event,
    Emitter<CreateTopicState> emit,
  ) async {
    emit(state.update(event.chat));
  }

  Future<void> onSave(
    SaveEventEvent event,
    Emitter<CreateTopicState> emit,
  ) async {
    emit(SavingTopicState(state));
    final messages = await _topicUseCase.saveTopic(state.chat);

    emit(messages.fold(
      (f) => CreationFailedState(state, f.toString()),
      (m) => TopicSavedState(state),
    ));
  }
}
