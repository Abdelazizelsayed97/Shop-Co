import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/core/utils/async.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/authentication/domain/use_case/log_out_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/fetch_user_data_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial()) {
    init();
  }
  init() {
    _fetchUserDataUseCase = injector();
    _logOutUseCase = injector();
  }

  late FetchUserDataUseCase _fetchUserDataUseCase;
  late LogOutUseCase _logOutUseCase;
  void fetchUserData(String userId) async {
    emit(state.reduce(fetchUserData: Async.loading()));
    final result = await _fetchUserDataUseCase.execute();
    result.fold(
      (l) => emit(state.reduce(fetchUserData: Async.failure(l.message ?? ""))),
      (r) => emit(state.reduce(fetchUserData: Async.success(r))),
    );
  }

  void logOut() async {
    emit(state.reduce(logOut: Async.loading()));
    final result = await _logOutUseCase.call();
    result.fold(
      (l) => emit(state.reduce(logOut: Async.failure(l.message ?? ""))),
      (r) => emit(state.reduce(logOut: Async.successWithoutData())),
    );
  }
}
