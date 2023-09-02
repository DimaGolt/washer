import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:washu/shared/domain/repositories/auth_repository.dart';

part 'login_state.dart';

part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState.initial());

  void loginWithEmail(String email, String password) async {
    emit(const LoginState.loading());
    try {
      await _authRepository.loginEmail(email, password);
    } catch (e) {
      emit(LoginState.error(e.toString()));
      return;
    }
    emit(const LoginState.success());
  }

  void loginGoogle() async {
    emit(const LoginState.loading());
    try {
      await _authRepository.loginGoogle();
    } catch (e) {
      emit(LoginState.error(e.toString()));
      return;
    }
    emit(const LoginState.success());
  }
}
