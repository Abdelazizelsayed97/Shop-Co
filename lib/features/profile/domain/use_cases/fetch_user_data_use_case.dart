import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/profile/domain/repository/profile_repository.dart';

class FetchUserDataUseCase {
  final ProfileRepository _profileRepository;
  FetchUserDataUseCase(this._profileRepository);
  Future<Either<ApiError, UserInfoEntity>> execute() {
    return _profileRepository.fetchUserData();
  }
}
