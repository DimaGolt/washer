import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/repositories/auth_repository.dart';

part 'register_state.dart';

part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegisterState.initial());

  void registerWithEmail(String email, String password, String fullName) async {
    emit(const RegisterState.loading());
    try {
      await _authRepository.createUserWithEmail(email, password, fullName);
    } catch (e) {
      emit(RegisterState.error(e.toString()));
      return;
    }
    emit(const RegisterState.success());
  }

  void registerGoogle() async {
    emit(const RegisterState.loading());
    try {
      User? error = await _authRepository.loginGoogle();
    } catch (e) {
      emit(RegisterState.error(e.toString()));
      return;
    }
    emit(const RegisterState.success());
  }
}
