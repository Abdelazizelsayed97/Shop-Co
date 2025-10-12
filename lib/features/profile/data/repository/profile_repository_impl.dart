import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/utils/const_strings.dart';
import 'package:e_commerce_web_app/core/utils/dio_service.dart';
import 'package:e_commerce_web_app/core/utils/local_hive_storage.dart';
import 'package:e_commerce_web_app/features/authentication/data/mapper/auth_mapper.dart';
import 'package:e_commerce_web_app/features/authentication/data/models/api_login_result_model.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/profile/domain/entity/order_entity.dart';
import 'package:e_commerce_web_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final HttpService _httpService = HttpService();
  @override
  Future<Either<ApiError, UserInfoEntity>> fetchUserData() async {
    UserInfoEntity? userData;
    await HiveStorageService.service
        .getModel(
          boxName: "CurrentUser",
          key: "CurrentUser",
          fromJson: (p0) => UserInfoEntity.fromJson(p0),
        )
        .then((value) {
          if (value != null) {
            userData = value;
          }
        });
    final response = await _httpService.get(
      "${ProfileEndPoints.getUserById}/${userData?.id}",
    );
    final data = ApiUserModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 201) {
      return Right(data.convertToEntity());
    } else {
      return Left(ApiError(message: "Something want wrong"));
    }
  }

  @override
  Future<Either<ApiError, Unit>> logout() async {
    try {
      var token = await HiveStorageService.service
          .getModel(
            boxName: "CurrentUser",
            key: "CurrentUser",
            fromJson: (p0) => UserInfoEntity.fromJson(p0),
          )
          .then((value) {
            if (value?.token != null) {
              return value?.token;
            }
          });
      final response = await _httpService.post(
        AuthEndPoints.logOutEndPoint,
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
      if (response.statusCode != 200) {
        return Left(ApiError(message: "Something want wrong"));
      } else {
        await HiveStorageService.service.deleteModel(
          boxName: "CurrentUser",
          key: "CurrentUser",
        );
        return Right(unit);
      }
    } catch (e) {
      print(e.toString());
      return Left(ApiError(message: "Something want wrong"));
    }
  }

  @override
  Future<Either<ApiError, Unit>> changePassword() async {
    try {
      var token = await HiveStorageService.service
          .getModel(
            boxName: "CurrentUser",
            key: "CurrentUser",
            fromJson: (p0) => UserInfoEntity.fromJson(p0),
          )
          .then((value) {
            if (value?.token != null) {
              return value?.token;
            }
          });
      final response = await _httpService.post(
        AuthEndPoints.logOutEndPoint,
        token: token,
      );
      if (response.statusCode != 200) {
        return Left(ApiError(message: "Something want wrong"));
      } else {
        await HiveStorageService.service.deleteModel(
          boxName: "CurrentUser",
          key: "CurrentUser",
        );
        return Right(unit);
      }
    } catch (e) {
      return Left(ApiError(message: "Something want wrong"));
    }
  }

  @override
  Future<Either<ApiError, Unit>> updateProfile() {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiError, List<OrderEntity>>> getOrders() async {
    // TODO: implement getOrders
    return Right([
      OrderEntity(
        id: '1',
        date: DateTime.now(),
        products: [
          ProductEntityModel(id: "1", name: 'Product 1', price: 100),
          ProductEntityModel(id: "2", name: 'Product 2', price: 200),
        ],
        totalPrice: 300,
      ),
      OrderEntity(
        id: '2',
        date: DateTime.now(),
        products: [ProductEntityModel(id: "3", name: 'Product 3', price: 150)],
        totalPrice: 150,
      ),
    ]);
  }

  @override
  Future<Either<ApiError, List<ProductEntityModel>>> getWishlist() {
    // TODO: implement getWishlist
    throw UnimplementedError();
  }
}
