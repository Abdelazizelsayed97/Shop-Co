part of 'otp_cubit.dart';

class OtpCodeState extends Equatable {
  final Async<UserInfoEntity> verifyEmailState;
  final Async<void> verifyResetPasswordState;
  const OtpCodeState({
    required this.verifyEmailState,
    required this.verifyResetPasswordState,
  });
  factory OtpCodeState.initial() => const OtpCodeState(
    verifyEmailState: Async.initial(),
    verifyResetPasswordState: Async.initial(),
  );
  OtpCodeState reduce({
    Async<UserInfoEntity>? verifyEmailState,
    Async<void>? verifyResetPasswordState,
  }) {
    return OtpCodeState(
      verifyEmailState: verifyEmailState ?? this.verifyEmailState,
      verifyResetPasswordState:
          verifyResetPasswordState ?? this.verifyResetPasswordState,
    );
  }

  @override
  List<Object?> get props => [verifyEmailState, verifyResetPasswordState];
}
