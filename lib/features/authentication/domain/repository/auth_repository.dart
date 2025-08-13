import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/login_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/register_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserInfoEntity>> login(LoginInput input);
  Future<Either<String, String>> register(RegisterInput input);
  Future<Either<String, String>> forgetPassword(String email);
  Future<Either<String, String>> resetPassword(
    String email,
    String newPassword,
  );
  Future<Either<ApiError, UserInfoEntity>> verifyEmail(
    String email,
    String otp,
  );
}
