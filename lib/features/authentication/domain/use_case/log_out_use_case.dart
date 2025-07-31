import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/profile/domain/repository/profile_repository.dart';

class LogOutUseCase {
  final ProfileRepository authRepository;
  LogOutUseCase(this.authRepository);

  Future<Either<ApiError, Unit>> call() {
    return authRepository.logout();
  }
}
