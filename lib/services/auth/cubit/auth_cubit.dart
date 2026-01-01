import 'package:bloc/bloc.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

import '../repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(const AuthInitial());

  /// Вызывается один раз при старте приложения
  Future<void> init() async {
    final hasSession = await _repository.hasSession();
    if (!hasSession) {
      emit(const AuthNotLoggedIn());
      return;
    }

    final authData = await _repository.restoreSession();
    emit(
      AuthLoggedIn(
        user: authData.userData,
        authData: authData,
      ),
    );
  }

  /// Успешная авторизация через VK ID
  Future<void> login(AuthData authData) async {
    await _repository.saveSession(authData);

    emit(
      AuthLoggedIn(
        user: authData.userData,
        authData: authData,
      ),
    );
  }

  /// Выход пользователя
  Future<void> logout() async {
    await _repository.clearSession();
    emit(const AuthNotLoggedIn());
  }
}
