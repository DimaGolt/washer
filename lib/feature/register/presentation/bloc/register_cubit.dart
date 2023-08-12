import 'package:bloc/bloc.dart';
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
    String? error = await _authRepository.createUserWithEmail(email, password, fullName);
    if (error != null) {
      emit(RegisterState.error(error));
      return;
    }
    emit(const RegisterState.success());
  }

  void registerGoogle() async {
    emit(const RegisterState.loading());
    String? error = await _authRepository.loginGoogle();
    if (error != null) {
      emit(RegisterState.error(error));
      return;
    }
    emit(const RegisterState.success());
  }
}
