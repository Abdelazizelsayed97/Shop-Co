import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/product_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GridView.builder(
                  itemCount: widget.products.length,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 850 ? 4 : 2,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                    // mainAxisExtent:getItemHeight(constraints, context)
                    // constraints.maxWidth > 850
                    //     ? MediaQuery.of(context).size.width * 0.35
                    //     : MediaQuery.of(context).size.height * 0.3,
                    childAspectRatio:
                        constraints.maxWidth > 1000
                            ? 1.8 / 2.7
                            : constraints.maxWidth > 850
                            ? 1.8 / 3.2
                            : 5 / 8.3,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItemBuilder(product: widget.products[index]);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
