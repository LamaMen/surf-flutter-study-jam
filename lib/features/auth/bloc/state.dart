part of 'bloc.dart';

class AuthState {
  final FormData data;
  final String? exception;
  final bool isLoading;
  final bool isAuthenticated;

  const AuthState._({
    required this.data,
    required this.exception,
    required this.isLoading,
    required this.isAuthenticated,
  });

  const AuthState.initial()
      : this._(
          data: const FormData.empty(),
          exception: null,
          isLoading: false,
          isAuthenticated: false,
        );

  AuthState update(FormData data) {
    return AuthState._(
      data: data,
      exception: null,
      isLoading: false,
      isAuthenticated: false,
    );
  }

  AuthState loading() {
    return AuthState._(
      data: data,
      exception: exception,
      isLoading: true,
      isAuthenticated: false,
    );
  }

  AuthState success() {
    return AuthState._(
      data: data,
      exception: null,
      isLoading: false,
      isAuthenticated: true,
    );
  }

  AuthState error(String e) {
    return AuthState._(
      data: data.clearPassword(),
      exception: e,
      isLoading: false,
      isAuthenticated: false,
    );
  }
}
