import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/login_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepositoryImpl(this._firebaseAuth);
  @override
  Future<Either<String, UserInfoEntity>> signInWithEmailandPassword(
    LoginInput input,
  ) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: input.email,
      password: input.password,
    );
    if (result.user != null) {
      return Right(UserInfoEntity());
    } else {
      return Left("User not found");
    }
  }

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
  Future<Either<String, UserInfoEntity>> signUpWithEmailandPassword(
    LoginInput input,
  ) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: input.email,
      password: input.password,
    );
    if (result.user != null) {
      return Right(UserInfoEntity());
    } else {
      return Left("User not found");
    }
  }
}
