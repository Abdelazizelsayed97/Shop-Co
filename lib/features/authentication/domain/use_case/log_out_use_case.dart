import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/features/authentication/domain/repository/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository authRepository;
  LogOutUseCase(this.authRepository);

  Future<Either<void, Unit>> call() {
    return authRepository.signOut();
  }
}
