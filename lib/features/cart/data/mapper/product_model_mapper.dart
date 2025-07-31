import '../../../../core/models/product_entity_model.dart';
import '../models/ai_cart_result_model.dart';

extension ConvertApiProductModelToProductEntity on ApiProductItemModel {
  ProductEntityModel toProductEntity() {
    return ProductEntityModel(
      id: id,
      description: description,
      price: price,
      rating: rating,
      stock: stock,
      brand: brand,
      productId: productId,
      name: name,
      images: [imageUrl ?? ""],
      quantity: quantity,
    );
  }
}
