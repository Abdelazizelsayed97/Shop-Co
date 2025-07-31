import 'package:dartz/dartz.dart';

import '../../../../core/helper/api_error_handler.dart';
import '../repository/profile_repository.dart';

class LogOutUseCase {
  final ProfileRepository profileRepository;
  LogOutUseCase(this.profileRepository);
  Future<Either<ApiError, Unit>> call() {
    return profileRepository.logout();
  }
}
