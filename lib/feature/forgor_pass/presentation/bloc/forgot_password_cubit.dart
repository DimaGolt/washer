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
    String? error = await _authRepository.forgotPassword(email);
    if (error != null) {
      emit(ForgotPasswordState.error(error));
      return;
    }
    emit(const ForgotPasswordState.success());
  }
}
