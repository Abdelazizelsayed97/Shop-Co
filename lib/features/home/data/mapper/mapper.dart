import 'package:e_commerce_web_app/features/home/data/models/api_fetch_dummy_products_result_model.dart';
import 'package:e_commerce_web_app/features/home/data/models/api_fetch_products_result_model.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/dummy_product_entity.dart';
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

extension ConvertApiDummyToEntity on ApiProduct {
  DummyProductEntity fromApi() {
    return DummyProductEntity(
      id: id,
      title: title,
      description: description,
      category: category?.fromApi(),
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      tags: tags,
      brand: brand,
      sku: sku,
      weight: weight,
      dimensions: dimensions,
      warrantyInformation: warrantyInformation,
      shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus,
      reviews: reviews,
      returnPolicy: returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity,
      meta: meta,
      images: images,
      thumbnail: thumbnail,
    );
  }
}

extension ConvertEnums on ApiCategory {
  CategoryEnum fromApi() {
    switch (this) {
      case ApiCategory.BEAUTY:
        return CategoryEnum.BEAUTY;
      case ApiCategory.FRAGRANCES:
        return CategoryEnum.FRAGRANCES;
      case ApiCategory.FURNITURE:
        return CategoryEnum.FURNITURE;
      case ApiCategory.GROCERIES:
        return CategoryEnum.GROCERIES;
    }
  }
}
