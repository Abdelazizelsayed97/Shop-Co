part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final Async<UserInfoEntity> loginState;
  final Async<String> signUpState;
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
    Async<String>? signUpState,
  }) {
    return AuthenticationState(
      loginState: loginState ?? this.loginState,
      signUpState: signUpState ?? this.signUpState,
    );
  }

  @override
  List<Object?> get props => [loginState, signUpState];
}
