import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/features/profile/data/repository/profile_repository_impl.dart';
import 'package:e_commerce_web_app/features/profile/domain/repository/profile_repository.dart';
import 'package:e_commerce_web_app/features/profile/domain/use_cases/fetch_user_data_use_case.dart';
import 'package:e_commerce_web_app/features/profile/ui/managers/profile_cubit.dart';

import '../../../authentication/domain/use_case/log_out_use_case.dart';

class ProfileDi {
  static void init() {
    injector.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(),
    );
    injector.registerLazySingleton<FetchUserDataUseCase>(
      () => FetchUserDataUseCase(injector()),
    );
    injector.registerLazySingleton<LogOutUseCase>(
      () => LogOutUseCase(injector()),
    );
    injector.registerFactory<ProfileCubit>(() => ProfileCubit());
  }
}
