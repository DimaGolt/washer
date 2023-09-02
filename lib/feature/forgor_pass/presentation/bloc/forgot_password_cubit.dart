import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/repositories/auth_repository.dart';

part 'forgot_password_state.dart';

part 'forgot_password_cubit.freezed.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const ForgotPasswordState.initial());

  Future<void> requestCode(String email) async {
    emit(const ForgotPasswordState.loading());
    try {
      await _authRepository.forgotPassword(email);
    } catch (e) {
      emit(ForgotPasswordState.error(e.toString()));
      return;
    }
    emit(const ForgotPasswordState.success());
  }
}
