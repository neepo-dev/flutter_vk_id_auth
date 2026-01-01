part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

/// Приложение только запустилось
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Пользователь НЕ авторизован
class AuthNotLoggedIn extends AuthState {
  const AuthNotLoggedIn();
}

/// Пользователь авторизован
class AuthLoggedIn extends AuthState {
  final User user;
  final AuthData authData;

  const AuthLoggedIn({
    required this.user,
    required this.authData,
  });
}
