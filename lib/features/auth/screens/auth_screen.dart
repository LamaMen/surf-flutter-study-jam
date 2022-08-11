import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/auth/bloc/bloc.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat_screen.dart';

/// Screen for authorization process.
class AuthScreen extends StatefulWidget {
  static const route = '/auth';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController _loginController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: SizedBox(
            height: 300,
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is CheckSucceededState) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  _pushToChat(context);
                } else if (state is CheckFailedState) {
                  final snackBar = SnackBar(
                    content: Text(state.exception.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (state is CheckUserDataState) {
                  const snackBar = SnackBar(
                    content: Text('Loading'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  const snackBar = SnackBar(
                    content: Text('Enter state'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Вход в чат'),
                  TextField(controller: _loginController),
                  TextField(controller: _passwordController, obscureText: true),
                  ElevatedButton(
                    onPressed: () {
                      final event = CheckUserDataEvent(
                        _loginController.text,
                        _passwordController.text,
                      );

                      context.read<AuthBloc>().add(event);
                    },
                    child: const Text('Войти'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pushToChat(BuildContext context) {
    Navigator.pushReplacementNamed(context, ChatScreen.route);
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
