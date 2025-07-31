import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/features/home/data/models/api_fetch_products_model_result.dart';
import 'package:e_commerce_web_app/features/home/data/models/api_fetch_products_result_model.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';

extension ConvertApiProductToEntity on Product {
  ProductEntity fromApi() {
    return ProductEntity(
      id: id,

      description: description,
      price: price?.toDouble(),
      // rate: rate,
      title: title,
      category: category?.fromApi(),
      images: images,
      creationAt: creationAt,
      updatedAt: updatedAt,
    );
  }
}

extension ConvertApiCategoryToEntity on Category {
  CaegoryEntity fromApi() {
    return CaegoryEntity(id: id, image: image);
  }
}

extension ConvertApiDummyToEntity on ApiProductModel {
  ProductEntityModel fromApi() {
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
    );
  }
}
