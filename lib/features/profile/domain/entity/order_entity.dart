import 'package:e_commerce_web_app/core/models/product_entity_model.dart';

class OrderEntity {
  final String id;
  final DateTime date;
  final List<ProductEntityModel> products;
  final double totalPrice;

  OrderEntity({
    required this.id,
    required this.date,
    required this.products,
    required this.totalPrice,
  });
}
