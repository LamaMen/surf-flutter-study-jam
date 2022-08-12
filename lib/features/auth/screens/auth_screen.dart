import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/core/widgets/buttons/simple_button.dart';
import 'package:surf_practice_chat_flutter/features/auth/bloc/bloc.dart';
import 'package:surf_practice_chat_flutter/features/auth/widgets/auth_field.dart';
import 'package:surf_practice_chat_flutter/features/topics/screens/topics_screen.dart';

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

    _loginController.addListener(onDataEnter);
    _passwordController.addListener(onDataEnter);

    super.initState();
  }

  void onDataEnter() {
    final event = EnterDataEvent(
      login: _loginController.text,
      password: _passwordController.text,
    );
    context.read<AuthBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: SizedBox(
            height: 300,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.isAuthenticated) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  Navigator.pushReplacementNamed(context, TopicsScreen.route);
                }

                if (state.exception != null) {
                  _passwordController.clear();
                  final snackBar = SnackBar(
                    content: Text(state.exception!),
                    backgroundColor: Colors.red,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Вход в чат',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 24),
                    AuthField(
                      hint: 'Логин',
                      icon: Icons.tag_faces,
                      controller: _loginController,
                    ),
                    const SizedBox(height: 16),
                    AuthField(
                      hint: 'Пароль',
                      icon: Icons.lock,
                      controller: _passwordController,
                      isProtected: true,
                    ),
                    const SizedBox(height: 16),
                    SimpleButton(
                      isActive: !state.data.isEmpty,
                      isLoading: state.isLoading,
                      title: 'Войти',
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        const event = CheckUserDataEvent();
                        context.read<AuthBloc>().add(event);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
