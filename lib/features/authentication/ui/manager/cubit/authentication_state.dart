part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final Async<UserInfoEntity> loginState;
  final Async<UserInfoEntity> signUpState;
  const AuthenticationState({
    required this.loginState,
    required this.signUpState,
  });
  factory AuthenticationState.init() {
    return AuthenticationState(
      loginState: Async.initial(),
      signUpState: Async.initial(),
    );
  }
  AuthenticationState reduce({
    Async<UserInfoEntity>? loginState,
    Async<UserInfoEntity>? signUpState,
  }) {
    return AuthenticationState(
      loginState: loginState ?? this.loginState,
      signUpState: signUpState ?? this.signUpState,
    );
  }

  @override
  List<Object?> get props => [loginState, signUpState];
}
