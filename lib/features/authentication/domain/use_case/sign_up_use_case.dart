import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/register_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);

  Future<Either<String, String>> execute(RegisterInput input) {
    return authRepository.register(input);
  }
}
