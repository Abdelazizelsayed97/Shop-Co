import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';

import '../repository/auth_repository.dart';

class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);
  Future<Either<ApiError, UserInfoEntity>> execute(String email, String otp) {
    return repository.verifyEmail(email, otp);
  }
}
