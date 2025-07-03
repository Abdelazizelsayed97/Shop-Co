import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/product_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductBodyWidget extends StatelessWidget {
  const ProductBodyWidget({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        shrinkWrap: true,
        itemCount: 4,
        scrollDirection: Axis.horizontal,

        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ProductItemBuilder(product: products[index]),
          );
        },
      ),
    );
  }
}
