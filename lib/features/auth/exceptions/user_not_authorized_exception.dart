import 'package:flutter/foundation.dart';

@immutable
class UserNotAuthorizedException implements Exception {
  const UserNotAuthorizedException();

  @override
  String toString() => 'User is not authorized';
}
