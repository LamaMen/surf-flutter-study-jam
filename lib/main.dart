import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/core/injectable/setup.dart';
import 'package:surf_practice_chat_flutter/features/auth/bloc/bloc.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth_screen.dart';
import 'package:surf_practice_chat_flutter/features/auth/usecase/token_storage.dart';
import 'package:surf_practice_chat_flutter/features/chat/bloc/bloc.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat_screen.dart';
import 'package:surf_practice_chat_flutter/features/splash/screen/splash_screen.dart';
import 'package:surf_practice_chat_flutter/features/topics/bloc/logout/bloc.dart';
import 'package:surf_practice_chat_flutter/features/topics/bloc/topics/bloc.dart';
import 'package:surf_practice_chat_flutter/features/topics/screens/topics_screen.dart';

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
      onGenerateRoute: _routes,
      routes: {
        SplashScreen.route: (_) => SplashScreen(storage: getIt<TokenStorage>()),
        TopicsScreen.route: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TopicsBloc>(create: (_) => getIt<TopicsBloc>()),
              BlocProvider<AppBarBloc>(create: (_) => getIt<AppBarBloc>()),
            ],
            child: const TopicsScreen(),
          );
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

  Route<dynamic>? _routes(RouteSettings settings) {
    if (settings.name == ChatScreen.route) {
      final chatId = settings.arguments as int? ?? 1;
      return MaterialPageRoute(
        builder: (_) {
          return BlocProvider<ChatBloc>(
            create: (_) => getIt<ChatBloc>(param1: chatId),
            child: const ChatScreen(),
          );
        },
      );
    }

    assert(false, 'Need to implement ${settings.name}');
    return null;
  }
}
