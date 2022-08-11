import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';
import 'package:surf_practice_chat_flutter/features/auth/usecase/auth_usecase.dart';

part 'event.dart';

part 'state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(const EnterDataState()) {
    on<CheckUserDataEvent>(onCheckUserData);
  }

  Future<void> onCheckUserData(
    CheckUserDataEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const CheckUserDataState());
    final answer = await _authUseCase.singIn(
      login: event.login,
      password: event.password,
    );

    emit(answer.fold(
      (e) => CheckFailedState(e),
      (t) => CheckSucceededState(t),
    ));
  }
}
