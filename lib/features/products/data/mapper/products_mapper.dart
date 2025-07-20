import '../../../../core/paginated_data.dart';
import '../../domain/entity/product_entity.dart';
import '../model/api_fetch_products_result_model.dart';

extension ConvertApiProductModelToProductEntity on ApiProductsModel {
  ProductsEntity toProductEntity() => ProductsEntity(
    id: id.toString(),
    description: description,
    price: price,
    brand: brand,
    rating: rating,
    stock: stock,
    imageUrl: imageUrl,
    name: name,
    productId: productId,
  );
}

extension ConvertApiProductModelListToProductEntityList
    on ApiShopCoResultModel {
  PaginatedData<ProductsEntity> convertToEntity() => PaginatedData(
    page: page,
    limit: limit,
    data: products?.map((e) => e.toProductEntity()).toList() ?? [],
    hasNext: true,
  );
}
