import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/core/result/result.dart';
import 'package:surf_practice_chat_flutter/features/auth/exceptions/user_not_authorized_exception.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';

const _tokenKey = 'token';

@singleton
class TokenStorage {
  final FlutterSecureStorage _secureStorage;

  TokenStorage(this._secureStorage);

  Future<void> save(TokenDto tokenDto) async {
    await _secureStorage.write(key: _tokenKey, value: tokenDto.token);
  }

  FutureResult<TokenDto> getCurrent() async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null) {
      return const Fail(UserNotAuthorizedException());
    } else {
      return Ok(TokenDto(token: token));
    }
  }

  Future<void> delete() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}
