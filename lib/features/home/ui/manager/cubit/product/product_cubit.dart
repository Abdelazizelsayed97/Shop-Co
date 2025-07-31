import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/utils/async.dart';
import 'package:e_commerce_web_app/features/home/domain/use_case/fetch_product_dummy_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/di/app_di.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState.initial()) {
    init();
  }
  late FetchProductDummyUseCase _dummyUseCase;
  void init() {
    _dummyUseCase = injector();
  }

  void fetchProducts(String? limit, String? skip) async {
    emit(state.reduce(fetchProducts: Async.loading()));
    final result = await _dummyUseCase.call(limit ?? "", skip ?? "");
    result.fold(
      (l) => emit(state.reduce(fetchProducts: Async.failure(l.message ?? ""))),
      (r) => emit(state.reduce(fetchProducts: Async.success(r))),
    );
  }
}
