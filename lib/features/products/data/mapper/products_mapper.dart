import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/paginated_data.dart';

import '../../../home/data/models/api_fetch_products_model_result.dart';
import '../model/api_get_product_by_id.dart';

extension ConvertApiProductModelToEntityModel on ApiProductModel {
  ProductEntityModel fromApiModel() {
    return ProductEntityModel(
      id: id,
      brand: brand,
      description: description,
      images: [imageUrl ?? ""],
      name: name,
      price: price,
      productId: productId,
      rating: rating,
      stock: stock,
    );
  }
}

extension ConvertProductsDataToEntity on ApiProductResultModel {
  PaginatedData<ProductEntityModel> toEntity() {
    return PaginatedData(
      data: products?.map((e) => e.fromApiModel()).toList() ?? [],
      hasNext: hasNext ?? false,
      limit: limit,
      page: page,
    );
  }
}
