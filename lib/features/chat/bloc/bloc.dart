import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/features/auth/usecase/auth_usecase.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/usecase/chat_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCase _chatUseCase;
  final AuthUseCase _authUseCase;

  ChatBloc(
    this._chatUseCase,
    this._authUseCase,
  ) : super(const ChatState.initial()) {
    on<GetMessagesEvent>(onGetMessages);
    on<SingOutEvent>(onSingOut);
    on<SendMessageEvent>(onSendMessage);
    on<SendGeolocationMessageEvent>(onSendGeolocationMessage);
  }

  Future<void> onGetMessages(
    GetMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(LoadingChatState(state));
    final messages = await _chatUseCase.getMessages();

    emit(messages.fold(
      (f) => FailedChatState(state, f.toString()),
      (m) => ChatState(messages: m),
    ));
  }

  Future<void> onSingOut(
    SingOutEvent event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _authUseCase.signOut();
    if (result) {
      emit(LogoutChatState(state));
    } else {
      emit(FailedChatState(state, 'Что-то пошло не так :)'));
    }
  }

  Future<void> onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(LoadingChatState(state));
    final messages = await _chatUseCase.sendMessage(event.message);

    emit(messages.fold(
      (f) => FailedChatState(state, f.toString()),
      (m) => ChatState(messages: m),
    ));
  }

  Future<void> onSendGeolocationMessage(
    SendGeolocationMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(LoadingChatState(state));
    final messages = await _chatUseCase.sendGeolocationMessage();

    emit(messages.fold(
          (f) => FailedChatState(state, f.toString()),
          (m) => ChatState(messages: m),
    ));
  }
}
