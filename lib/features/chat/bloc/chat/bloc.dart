import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/usecase/chat_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCase _chatUseCase;

  ChatBloc(
    @factoryParam int id,
    this._chatUseCase,
  ) : super(ChatState.initial(id)) {
    on<GetMessagesEvent>(onGetMessages);
    on<SendMessageEvent>(onSendMessage);
    on<SendGeolocationMessageEvent>(onSendGeolocationMessage);
  }

  Future<void> onGetMessages(
    GetMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(LoadingChatState(state));
    final messages = await _chatUseCase.getMessages(state.chatId);

    emit(messages.fold(
      (f) => FailedChatState(state, f.toString()),
      (m) => state.copyWithMessages(m),
    ));
  }

  Future<void> onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(LoadingChatState(state));
    final messages = await _chatUseCase.sendMessage(
      chatId: state.chatId,
      message: event.message,
    );

    emit(messages.fold(
      (f) => FailedChatState(state, f.toString()),
      (m) => state.copyWithMessages(m),
    ));
  }

  Future<void> onSendGeolocationMessage(
    SendGeolocationMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(LoadingChatState(state));
    final messages = await _chatUseCase.sendGeolocationMessage(state.chatId);

    emit(messages.fold(
      (f) => FailedChatState(state, f.toString()),
      (m) => state.copyWithMessages(m),
    ));
  }
}
