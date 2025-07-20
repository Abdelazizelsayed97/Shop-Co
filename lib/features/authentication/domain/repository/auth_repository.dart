import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/login_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/register_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserInfoEntity>> login(LoginInput input);
  Future<Either<String, UserInfoEntity>> register(RegisterInput input);
  Future<Either<String, String>> forgetPassword(String email);
  Future<Either<String, String>> resetPassword(
    String email,
    String newPassword,
  );
  Future<Either<String, String>> verifyEmail(String email, String otp);
  Future<Either<void, Unit>> signOut();
}
