import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/core/utils/async.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/use_case/fetch_product_dummy_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/product_entity_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.init()) {
    init();
  }
  late FetchProductDummyUseCase _fetchProductDummyUseCase;
  void init() {
    _fetchProductDummyUseCase = injector();
  }

  void fetchDummyProducts({String? limit, String? skip}) async {
    emit(state.reduce(dummyProducts: Async.loading()));
    final result = await _fetchProductDummyUseCase.call(
      limit ?? "",
      skip ?? "",
    );
    result.fold(
      (l) {
        print('Failure ${l.message}');
        emit(state.reduce(dummyProducts: Async.failure(l.message ?? "")));
      },
      (r) {
        print('SuccessfetchDummyProducts ${r}');
        emit(state.reduce(dummyProducts: Async.success(r)));
      },
    );
  }
}
