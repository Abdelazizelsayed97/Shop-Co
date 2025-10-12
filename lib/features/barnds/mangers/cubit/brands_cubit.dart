
import 'package:e_commerce_web_app/core/utils/async.dart';
import 'package:e_commerce_web_app/features/barnds/domain/entity/brand_entity.dart';
import 'package:e_commerce_web_app/features/barnds/domain/use_cases/fetch_brands_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'brands_state.dart';

class BrandsCubit extends Cubit<BrandsState> {
  BrandsCubit() : super(BrandsState.initial());
  late FetchBrandsUseCase _fetchBrandsUseCase;

  void fetchBrands() async {
    emit(state.reduce(brands: Async.loading()));
    final result = await _fetchBrandsUseCase.execute();
    result.fold(
      (l) => emit(state.reduce(brands: Async.failure(l.message ?? ""))),
      (r) => emit(state.reduce(brands: Async.success(r))),
    );
  }
}
