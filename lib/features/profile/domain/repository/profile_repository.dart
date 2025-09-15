import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/profile/domain/entity/order_entity.dart';

abstract class ProfileRepository {
  Future<Either<ApiError, UserInfoEntity>> fetchUserData();
  Future<Either<ApiError, Unit>> logout();
  Future<Either<ApiError, Unit>> updateProfile();
  Future<Either<ApiError, Unit>> changePassword();
  Future<Either<ApiError, List<OrderEntity>>> getOrders();
  Future<Either<ApiError, List<ProductEntityModel>>> getWishlist();
}
