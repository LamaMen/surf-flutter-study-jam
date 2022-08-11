import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/features/auth/exceptions/auth_exception.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/form_data.dart';
import 'package:surf_practice_chat_flutter/features/auth/usecase/auth_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(const AuthState.initial()) {
    on<CheckUserDataEvent>(onCheckUserData);
    on<EnterDataEvent>(onEnterData);
  }

  Future<void> onCheckUserData(
    CheckUserDataEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.loading());
    final answer = await _authUseCase.singIn(data: state.data);

    emit(answer.fold(
      (e) {
        final message = e is AuthException
            ? e.message
            : 'Ошибка. Проверьте подключение или повторите позже.';
        return state.error(message);
      },
      (_) => state.success(),
    ));
  }

  void onEnterData(EnterDataEvent event, Emitter<AuthState> emit) {
    emit(state.update(event.data));
  }
}
