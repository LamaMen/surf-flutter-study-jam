import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/core/result/result.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_location_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';

@singleton
class ChatUseCase {
  final IChatRepository _chatRepository;

  ChatUseCase(this._chatRepository);

  FutureResult<Iterable<ChatMessageDto>> getMessages(int chatId) async {
    try {
      final newMessages = await _fetchMessages(chatId);
      return Ok(newMessages);
    } on Exception catch (e) {
      return Fail(e);
    }
  }

  FutureResult<Iterable<ChatMessageDto>> sendMessage({
    required String message,
    required int chatId,
  }) async {
    try {
      await _chatRepository.sendMessage(chatId: chatId, message: message);
      final newMessages = await _fetchMessages(chatId);
      return Ok(newMessages);
    } on Exception catch (e) {
      return Fail(e);
    }
  }

  FutureResult<Iterable<ChatMessageDto>> sendGeolocationMessage(
    int chatId,
  ) async {
    try {
      await _chatRepository.sendGeolocationMessage(
        chatId: chatId,
        location: await _determinePosition(),
        message: 'Мое расположение :)',
      );

      final newMessages = await _fetchMessages(chatId);
      return Ok(newMessages);
    } on Exception catch (e) {
      return Fail(e);
    }
  }

  Future<Iterable<ChatMessageDto>> _fetchMessages(int chatId) async {
    final rawMessages = await _chatRepository.getMessages(chatId);
    if (rawMessages.isEmpty) return [];

    final userIds = rawMessages.map((m) => m.userId).toSet().toList();
    final users = await _chatRepository.getUsers(userIds);

    final messages = <ChatMessageDto>[];
    for (var i = 0; i < rawMessages.length; i++) {
      final m = rawMessages[i];
      final user = users.firstWhere((userDto) => userDto.id == m.userId);
      late final bool isLast;

      if (i != (rawMessages.length - 1)) {
        final next = rawMessages[i + 1];
        isLast = m.userId != next.userId;
      } else {
        isLast = true;
      }

      messages.add(m.geopoint == null
          ? ChatMessageDto.fromSJClient(message: m, user: user, isLast: isLast)
          : ChatMessageGeolocationDto.fromSJClient(
              message: m,
              user: user,
              isLast: isLast,
            ));
    }

    final me = messages
        .where((m) =>
            (m is ChatMessageGeolocationDto && m.location.isValid) ||
            (m is! ChatMessageGeolocationDto &&
                m.message != null &&
                m.message!.isNotEmpty))
        .toList();

    return me;
  }

  Future<ChatGeolocationDto> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();
    return ChatGeolocationDto(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
