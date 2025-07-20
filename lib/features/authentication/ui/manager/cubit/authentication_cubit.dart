import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/core/utils/async.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/login_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/authentication/domain/use_case/sign_in_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/sign_up_use_case.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState.init()) {
    init();
  }
  late SignInUseCase _signInUseCase;
  late SignUpUseCase _signUpUseCase;
  void init() {
    _signUpUseCase = injector();
    _signInUseCase = injector();
  }

  void login(LoginInput loginInput) async {
    emit(state.reduce(loginState: Async.loading()));
    final result = await _signInUseCase.call(loginInput);
    result.fold(
      (l) => emit(state.reduce(loginState: Async.failure(l))),
      (r) => emit(state.reduce(loginState: Async.success(r))),
    );
  }

  void signUpFunction(LoginInput loginInput) async {
    emit(state.reduce(signUpState: Async.loading()));
    final result = await _signInUseCase.call(loginInput);
    result.fold(
      (l) => emit(state.reduce(signUpState: Async.failure(l))),
      (r) => emit(state.reduce(signUpState: Async.success(r))),
    );
  }
}
