import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/core/utils/async.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/dummy_product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/use_case/fetch_product_dummy_use_case.dart';
import 'package:e_commerce_web_app/features/home/domain/use_case/fetch_products_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.init()) {
    init();
  }
  late FetchProductsUseCase _fetchProductsUseCase;
  late FetchProductDummyUseCase _fetchProductDummyUseCase;
  void init() {
    _fetchProductsUseCase = injector();
    _fetchProductDummyUseCase = injector();
  }

  void getProducts() async {
    emit(state.reduce(products: Async.loading()));
    final result = await _fetchProductsUseCase.call();
    result.fold(
      (l) {
        print('Failure ${l.message}');
        emit(state.reduce(products: Async.failure(l.message ?? "")));
      },
      (r) {
        print('Success ${r}');
        emit(state.reduce(products: Async.success(r)));
      },
    );
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
