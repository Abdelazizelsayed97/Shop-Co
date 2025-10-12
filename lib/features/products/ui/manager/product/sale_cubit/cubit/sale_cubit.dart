import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/paginated_data.dart';
import 'package:e_commerce_web_app/core/utils/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sale_state.dart';

class SaleCubit extends Cubit<SaleState> {
  SaleCubit() : super(SaleState.initial());

  void fetchSaleProducts() async {
    emit(state.reduce(products: Async.loading()));
    final result = await Future.delayed(const Duration(seconds: 2));
    result.fold(
      (l) => emit(state.reduce(products: Async.failure(l.message ?? ""))),
      (r) => emit(state.reduce(products: Async.success(r))),
    );
  }
}
