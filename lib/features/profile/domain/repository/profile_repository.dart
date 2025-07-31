import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<ApiError, UserInfoEntity>> fetchUserData();
  Future<Either<ApiError, Unit>> logout();
}
