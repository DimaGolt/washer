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
    String? error = await _authRepository.loginEmail(email, password);
    if(error != null) {
      emit(LoginState.error(error));
      return;
    }
    emit(const LoginState.success());
  }

  void loginGoogle() async {
    emit(const LoginState.loading());
    String? error = await _authRepository.loginGoogle();
    if(error != null) {
      emit(LoginState.error(error));
      return;
    }
    emit(const LoginState.success());
  }
}
