import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/login_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/authentication/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;
  SignInUseCase(this.authRepository);

  Future<Either<String, UserInfoEntity>> call(LoginInput input) {
    return authRepository.signInWithEmailandPassword(input);
  }
}
