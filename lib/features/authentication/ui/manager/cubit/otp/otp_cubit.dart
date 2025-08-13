import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/authentication/domain/use_case/verify_email_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/di/app_di.dart';
import '../../../../../../core/utils/async.dart';

part 'otp_state.dart';

class OtpCodeCubit extends Cubit<OtpCodeState> {
  OtpCodeCubit() : super(OtpCodeState.initial()) {
    init();
  }
  late VerifyEmailUseCase _verifyOtpUseCase;
  init() {
    _verifyOtpUseCase = injector();
  }

  void codeChanged(String code, String email) async {
    emit(state.reduce(verifyEmailState: Async.loading()));
    final result = await _verifyOtpUseCase.execute(email, code);
    result.fold(
      (l) =>
          emit(state.reduce(verifyEmailState: Async.failure(l.message ?? ""))),
      (r) => emit(state.reduce(verifyEmailState: Async.success(r))),
    );
  }

  void verifyResetPassword(String email, String otp) async {
    emit(state.reduce(verifyResetPasswordState: Async.loading()));
    final result = await _verifyOtpUseCase.execute(email, otp);
    result.fold(
      (l) => emit(
        state.reduce(verifyResetPasswordState: Async.failure(l.message ?? "")),
      ),
      (r) => emit(
        state.reduce(verifyResetPasswordState: Async.successWithoutData()),
      ),
    );
  }
}
