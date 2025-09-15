import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/profile/domain/entity/order_entity.dart';
import 'package:e_commerce_web_app/features/profile/domain/repository/profile_repository.dart';

class GetOrdersUseCase {
  final ProfileRepository _profileRepository;

  GetOrdersUseCase(this._profileRepository);

  Future<Either<ApiError, List<OrderEntity>>> execute() {
    return _profileRepository.getOrders();
  }
}
