import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/login_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserInfoEntity>> signInWithEmailandPassword(
    LoginInput input,
  );
  Future<Either<String, UserInfoEntity>> signUpWithEmailandPassword(
    LoginInput input,
  );
  Future<Either<void, Unit>> signOut();
}
