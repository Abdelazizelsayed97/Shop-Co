import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/utils/async.dart';
import 'package:e_commerce_web_app/features/home/domain/use_case/fetch_product_dummy_use_case.dart';
import 'package:e_commerce_web_app/features/products/domain/use_cases/product_details_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState.initial()) {
    init();
  }
  late FetchProductDummyUseCase _dummyUseCase;
  late ProductDetailsUseCase _productDetailsUseCase;
  void init() {
    _dummyUseCase = injector();
    _productDetailsUseCase = injector();
  }

  void fetchProducts(String? limit, String? skip) async {
    emit(state.reduce(fetchProducts: Async.loading()));
    final result = await _dummyUseCase.call(limit ?? "", skip ?? "");
    result.fold(
      (l) => emit(state.reduce(fetchProducts: Async.failure(l.message ?? ""))),
      (r) => emit(state.reduce(fetchProducts: Async.success(r))),
    );
  }

  void fetchProductDetails(String id) async {
    emit(state.reduce(productDetails: Async.loading()));
    final result = await _productDetailsUseCase.execute(id);
    result.fold(
      (l) => emit(state.reduce(productDetails: Async.failure(l.message ?? ""))),
      (r) {
        print('SuccessfetchProductDetails $r');

      
        emit(state.reduce(productDetails: Async.success(r)));
      },
    );
  }
}
