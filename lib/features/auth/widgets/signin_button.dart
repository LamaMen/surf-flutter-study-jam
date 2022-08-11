import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/auth/bloc/bloc.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final bool isLoading;
  final bool isActive;

  const SignInButton({
    super.key,
    required this.isLoading,
    required this.isActive,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: !isLoading && isActive ? () => signIn(context) : null,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                'Войти',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
      ),
    );
  }

  void signIn(BuildContext context) {
    voidCallback();
    const event = CheckUserDataEvent();
    context.read<AuthBloc>().add(event);
  }
}
