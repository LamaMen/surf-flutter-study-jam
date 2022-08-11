import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/features/auth/usecase/token_storage.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

@singleton
class Client {
  final StudyJamClient client = StudyJamClient();
  final TokenStorage _tokenStorage;

  Client(this._tokenStorage);

  Future<String> signin(String login, String password) =>
      client.signin(login, password);

  Future<void> logout() async {
    final secureClient = await _getClient();
    return secureClient.logout();
  }

  Future<SjUserDto?> getUser([int? id]) async {
    final secureClient = await _getClient();
    return secureClient.getUser(id);
  }

  Future<List<SjUserDto>> getUsers(List<int> ids) async {
    final secureClient = await _getClient();
    return secureClient.getUsers(ids);
  }

  Future<SjUpdatesIdsDto> getUpdates({
    DateTime? users,
    DateTime? msgs,
  }) async {
    final secureClient = await _getClient();
    return secureClient.getUpdates(
      users: users,
      msgs: msgs,
    );
  }

  Future<List<SjMessageDto>> getMessagesByIds(List<int> ids) async {
    final secureClient = await _getClient();
    return secureClient.getMessagesByIds(ids);
  }

  Future<List<SjMessageDto>> getMessages({
    int? lastMessageId,
    int? limit,
  }) async {
    final secureClient = await _getClient();
    return secureClient.getMessages(
      lastMessageId: lastMessageId,
      limit: limit,
    );
  }

  Future<SjMessageDto> sendMessage(SjMessageSendsDto msg) async {
    final secureClient = await _getClient();
    return secureClient.sendMessage(msg);
  }

  Future<SjChatDto> getChat() async {
    final secureClient = await _getClient();
    return secureClient.getChat();
  }

  Future<StudyJamClient> _getClient() async {
    final token = await _tokenStorage.getCurrent();
    return client.getAuthorizedClient(token.right.token);
  }
}
