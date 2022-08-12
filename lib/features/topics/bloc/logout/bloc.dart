import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/features/auth/usecase/auth_usecase.dart';

part 'event.dart';
part 'state.dart';

@injectable
class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  final AuthUseCase _authUseCase;

  AppBarBloc(this._authUseCase) : super(const AppBarState()) {
    on<SingOutEvent>(onSingOut);
  }

  Future<void> onSingOut(
    SingOutEvent event,
    Emitter<AppBarState> emit,
  ) async {
    final result = await _authUseCase.signOut();
    if (result) {
      emit(const LogoutState());
    } else {
      emit(const FailedChatState('Что-то пошло не так :)'));
    }
  }
}
