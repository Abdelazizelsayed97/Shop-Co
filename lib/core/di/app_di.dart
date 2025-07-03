import 'package:e_commerce_web_app/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:e_commerce_web_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:e_commerce_web_app/features/authentication/domain/use_case/sign_in_use_case.dart';
import 'package:e_commerce_web_app/features/authentication/ui/manager/cubit/authentication_cubit.dart';
import 'package:e_commerce_web_app/features/home/data/di/home_di.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

class AppDi {
  void init() {
    injector.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(injector()),
    );
    injector.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(injector()),
    );
    injector.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    injector.registerFactory<AuthenticationCubit>(
      () => AuthenticationCubit(injector()),
    );
    HomeDi.init();
  }
}
