import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/utils/const_strings.dart';
import 'package:e_commerce_web_app/core/utils/dio_service.dart';
import 'package:e_commerce_web_app/core/utils/local_hive_storage.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final HttpService _httpService = HttpService();
  @override
  Future<Either<ApiError, UserInfoEntity>> fetchUserData() async {
    print('fetchUserData at profile repository');
    UserInfoEntity? _userData;
    await HiveStorageService.service
        .getModel(
          boxName: "CurrentUser",
          key: "CurrentUser",
          fromJson: (p0) => UserInfoEntity.fromJson(p0),
        )
        .then((value) {
          if (value != null) {
            _userData = value;
          }
        });
    print('current user ${_userData}');
    final response = await _httpService.get(
      "${ProfileEndPoints.getUserById}/${_userData?.id}",
    );
    if (response.statusCode != 200) {
      return Left(ApiError(message: "Something want wrong"));
    } else {
      return Right(UserInfoEntity());
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
              print('hhheeehy');
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
        print('success');
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
}
