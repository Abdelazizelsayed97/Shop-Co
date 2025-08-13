import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/utils/const_strings.dart';
import 'package:e_commerce_web_app/core/utils/dio_service.dart';
import 'package:e_commerce_web_app/features/authentication/data/mapper/auth_mapper.dart';
import 'package:e_commerce_web_app/features/authentication/data/models/api_login_result_model.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/login_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/register_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:http/http.dart' as http;

import '../../../../core/helper/api_error_handler.dart';

class AuthRepositoryImpl extends AuthRepository {
  HttpService httpService = HttpService();

  @override
  Future<Either<String, UserInfoEntity>> login(LoginInput input) async {
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(
      Uri.parse(appEndpoint + AuthEndPoints.loginEndPoint),
      headers: headers,
      body: jsonEncode({'email': input.email, 'password': input.password}),
    );
    final data = ApiSignInResultModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return Right(data.user?.convertToEntity() ?? UserInfoEntity());
    } else {
      return Left(data.message ?? "");
    }
  }

  @override
  Future<Either<String, String>> forgetPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiError, UserInfoEntity>> verifyEmail(
    String userId,
    String otp,
  ) async {
    final response = await httpService.post(
      AuthEndPoints.verifyEmail,
      body: {"userId": userId, "otp": otp},
    );
    print('data entered $userId $otp');
    final data = ApiSignInResultModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return Right(data.user?.convertToEntity() ?? UserInfoEntity());
    } else {
      return Left(ApiError(message: data.message ?? ""));
    }
  }

  @override
  Future<Either<String, String>> register(RegisterInput input) async {
    final response = await httpService.post(
      AuthEndPoints.registerEndPoint,
      body: {
        "email": input.email,
        "password": input.password,
        "firstName": input.firstName,
        "lastName": input.lastName,
        "phone": input.phone,
      },
    );
    print("bodddyy ${response.body}");
    print('decoding  ${jsonDecode(response.body)["userId"]}');
    final data = jsonDecode(response.body);
    if (response.statusCode == 202) {
      return Right(data["userId"]);
    } else {
      return Left(data["message"]);
    }
  }

  @override
  Future<Either<String, String>> resetPassword(
    String email,
    String newPassword,
  ) async {
    final response = await httpService.post(
      AuthEndPoints.resetPassword,
      body: {"email": email, "password": newPassword},
    );

    final data = ApiSignInResultModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return Right("Password reset successfully");
    } else {
      return Left(data.message ?? "");
    }
  }
}
