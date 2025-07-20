import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/utils/const_strings.dart';
import 'package:e_commerce_web_app/core/utils/http_services.dart';
import 'package:e_commerce_web_app/features/authentication/data/mapper/auth_mapper.dart';
import 'package:e_commerce_web_app/features/authentication/data/models/api_login_result_model.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/login_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/register_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  HttpService httpService = HttpService(baseUrl: ShopCoApi.appEndpoint);

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<Either<void, Unit>> signOut() async {
    await _firebaseAuth.signOut();
    if (_firebaseAuth.currentUser == null) {
      return Right(unit);
    } else {
      return Left("Failed toƒ sign out");
    }
  }

  @override
  Future<Either<String, UserInfoEntity>> login(LoginInput input) async {
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(
      Uri.parse(ShopCoApi.appEndpoint + ShopCoApi.loginEndPoint),
      headers: headers,
      body: jsonEncode({'email': input.email, 'password': input.password}),
    );
    print('---- ${response.body}');
    final data = ApiSignInResultModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      print(response.body);
      return Right(data.user?.convertToEntity() ?? UserInfoEntity());
    } else {
      print(response.reasonPhrase);
      return Left(data.message ?? "");
    }
  }

  Future<Either<String, bool>> sendResetOtp(String email) async {
    try {
      final res = await httpService.post(ShopCoApi.forgetPassword, {
        'email': email,
      });
      return res.statusCode == 200 ? Right(true) : Left("OTP request failed");
    } catch (e) {
      return Left("Error: $e");
    }
  }

  Future<Either<String, bool>> verifyOtp(Map<String, dynamic> data) async {
    try {
      final res = await httpService.post(ShopCoApi.verifyResetOtp, data);
      return res.statusCode == 200 ? Right(true) : Left("Invalid OTP");
    } catch (e) {
      return Left("Error: $e");
    }
  }

  @override
  Future<Either<String, String>> forgetPassword(String email) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> verifyEmail(String email, String otp) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<String, UserInfoEntity>> register(RegisterInput input) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> resetPassword(
    String email,
    String newPassword,
  ) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
