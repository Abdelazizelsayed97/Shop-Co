import 'package:e_commerce_web_app/features/home/data/models/api_fetch_dummy_products_result_model.dart';
import 'package:e_commerce_web_app/features/home/data/models/api_fetch_products_result_model.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/dimensions_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/dummy_product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/dummy_review_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/meta_data_entity.dart';
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
      dimensions: dimensions?.fromApi(),
      warrantyInformation: warrantyInformation,
      shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus?.fromApi(),
      reviews: reviews?.map((e) => e.fromApi()).toList(),
      returnPolicy: returnPolicy?.fromApiEnum(),
      minimumOrderQuantity: minimumOrderQuantity,
      meta: meta?.fromApi(),
      images: images,
      thumbnail: thumbnail,
    );
  }
}

extension ConvertApiDimensionsToEntity on ApiDimensionsModel {
  DimensionsEntity fromApi() {
    return DimensionsEntity(height: height, depth: depth, width: width);
  }
}

extension ConvertApiDummyReviewToEntity on ApiReviewModel {
  DummyReviewEntity fromApi() {
    return DummyReviewEntity(
      comment: comment,
      date: date,
      rating: rating,
      reviewerEmail: reviewerEmail,
      reviewerName: reviewerName,
    );
  }
}

extension ConvertApiMetaDataToEntity on ApiMetaModel {
  MetaDataEntity fromApi() {
    return MetaDataEntity(
      barcode: barcode,
      createdAt: createdAt,
      qrCode: qrCode,
      updatedAt: updatedAt,
    );
  }
}

extension ConvertApiAvailabilityStatusEnumEnumsToEntity
    on ApiAvailabilityStatusEnum {
  AvailabilityStatusEnum fromApi() {
    switch (this) {
      case ApiAvailabilityStatusEnum.IN_STOCK:
        return AvailabilityStatusEnum.IN_STOCK;
      case ApiAvailabilityStatusEnum.LOW_STOCK:
        return AvailabilityStatusEnum.LOW_STOCK;
    }
  }
}

extension ConvertApiReturnPolicyEnumEnumsToEntity on ApiReturnPolicyEnum {
  ReturnPolicyEnum fromApiEnum() {
    switch (this) {
      case ApiReturnPolicyEnum.NO_RETURN_POLICY:
        return ReturnPolicyEnum.NO_RETURN_POLICY;
      case ApiReturnPolicyEnum.THE_30_DAYS_RETURN_POLICY:
        return ReturnPolicyEnum.THE_30_DAYS_RETURN_POLICY;
      case ApiReturnPolicyEnum.THE_60_DAYS_RETURN_POLICY:
        return ReturnPolicyEnum.THE_60_DAYS_RETURN_POLICY;
      case ApiReturnPolicyEnum.THE_7_DAYS_RETURN_POLICY:
        return ReturnPolicyEnum.THE_7_DAYS_RETURN_POLICY;
      case ApiReturnPolicyEnum.THE_90_DAYS_RETURN_POLICY:
        return ReturnPolicyEnum.THE_90_DAYS_RETURN_POLICY;
    }
  }
}

extension ConvertEnums on ApiCategoryEnum {
  CategoryEnum fromApi() {
    switch (this) {
      case ApiCategoryEnum.BEAUTY:
        return CategoryEnum.BEAUTY;
      case ApiCategoryEnum.FRAGRANCES:
        return CategoryEnum.FRAGRANCES;
      case ApiCategoryEnum.FURNITURE:
        return CategoryEnum.FURNITURE;
      case ApiCategoryEnum.GROCERIES:
        return CategoryEnum.GROCERIES;
    }
  }
}
