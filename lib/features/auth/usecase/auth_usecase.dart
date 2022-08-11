import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/core/result/result.dart';
import 'package:surf_practice_chat_flutter/features/auth/exceptions/auth_exception.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/form_data.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/auth/usecase/token_storage.dart';

@singleton
class AuthUseCase {
  final IAuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  AuthUseCase(this._authRepository, this._tokenStorage);

  FutureResult<TokenDto> singIn({
    required FormData data,
  }) async {
    try {
      final token = await _authRepository.signIn(
        login: data.login,
        password: data.password,
      );

      await _tokenStorage.save(token);
      return Ok(token);
    } on AuthException catch (e) {
      return Fail(e);
    }
  }

  Future<bool> signOut() async {
    try {
      await _authRepository.signOut();
      await _tokenStorage.delete();
      return true;
    } catch (_) {
      return false;
    }
  }
}
