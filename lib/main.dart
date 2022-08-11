import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/core/injectable/setup.dart';
import 'package:surf_practice_chat_flutter/features/auth/bloc/bloc.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth_screen.dart';
import 'package:surf_practice_chat_flutter/features/auth/usecase/token_storage.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat_screen.dart';
import 'package:surf_practice_chat_flutter/features/splash/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (_) => SplashScreen(storage: getIt<TokenStorage>()),
        ChatScreen.route: (_) {
          return ChatScreen(chatRepository: getIt<IChatRepository>());
        },
        AuthScreen.route: (_) {
          return BlocProvider<AuthBloc>(
            create: (_) => getIt<AuthBloc>(),
            child: const AuthScreen(),
          );
        },
      },
    );
  }
}
