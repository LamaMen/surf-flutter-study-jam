import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/core/result/result.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth_screen.dart';
import 'package:surf_practice_chat_flutter/features/auth/usecase/token_storage.dart';
import 'package:surf_practice_chat_flutter/features/topics/screens/topics_screen.dart';

class SplashScreen extends StatelessWidget {
  final TokenStorage storage;

  static const route = '/';

  const SplashScreen({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Result<TokenDto>>(
        future: storage.getCurrent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            final route = data.fold(
              (_) => AuthScreen.route,
              (_) => TopicsScreen.route,
            );

            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.pushReplacementNamed(context, route),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
