import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_dto.dart';

part 'event.dart';

part 'state.dart';

@injectable
class ChatTitleBloc extends Bloc<ChatTitleEvent, ChatTitleState> {
  final IChatRepository _chatRepository;

  ChatTitleBloc(
    @factoryParam ChatTopicDto chat,
    this._chatRepository,
  ) : super(ChatTitleState.initial(chat)) {
    on<GetTitleEvent>(onGetTitle);

    add(const GetTitleEvent());
  }

  Future<void> onGetTitle(
    GetTitleEvent event,
    Emitter<ChatTitleState> emit,
  ) async {
    final user = await _chatRepository.getLocalUser();
    emit(state.setUser(user));
  }
}
