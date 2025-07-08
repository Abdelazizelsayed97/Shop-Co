import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/dummy_product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/text_styles.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, this.products, this.dummyProducts});
  final ProductEntity? products;
  final DummyProductEntity? dummyProducts;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    print('products >> ${widget.products}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20).h,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 1000;
              return Flex(
                direction: isWide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Left side - images
                  _buildImagePreviewSection,

                  SizedBox(width: isWide ? 40 : 0, height: isWide ? 0 : 30),

                  /// Right side - details
                  Flexible(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ONE LIFE GRAPHIC T-SHIRT',
                          style: TextStyles.boldFont(fontSize: 18),
                        ),
                        12.responsiveHeight(),

                        /// Rating
                        Row(
                          children: [
                            ...List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                            ),
                            8.responsiveWidth(),
                            const Text('4.5/5'),
                          ],
                        ),

                        20.responsiveHeight(),

                        /// Price
                        Row(
                          children: [
                            Text(
                              '\$260',
                              style: TextStyles.boldFont(fontSize: 18),
                            ),
                            12.responsiveWidth(),
                            Text(
                              '\$300',
                              style: TextStyles.regularFont(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),

                        16.responsiveHeight(),
                        const Text(
                          'This graphic t-shirt which is perfect for any occasion. Crafted from a soft and breathable fabric, it offers superior comfort and style.',
                        ),

                        16.responsiveHeight(),

                        /// Colors
                        const Text('Select Colors'),
                        8.responsiveHeight(),
                        Row(
                          children: [
                            _buildColorDot(Colors.brown),
                            _buildColorDot(Colors.green),
                            _buildColorDot(Colors.blue),
                            _buildColorDot(Colors.black),
                          ],
                        ),

                        20.responsiveHeight(), const Text('Choose Size'),
                        8.responsiveHeight(),
                        Wrap(
                          spacing: 12.w,
                          children: [
                            _buildSizeBox('Small'),
                            _buildSizeBox('Medium'),
                            _buildSizeBox('Large', isSelected: true),
                            _buildSizeBox('X-Large'),
                          ],
                        ),

                        20.responsiveHeight(),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {},
                                  ),
                                  const Text('1'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 18,
                                ),
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {},
                              child: const Text('Add to Cart'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Flexible get _buildImagePreviewSection {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Thumbnails
          Column(
            children: List.generate(
              widget.products?.image?.isNotEmpty ?? false
                  ? 1
                  : widget.products?.images?.length ?? 0,
              (index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: index == 0 ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      widget.products?.image?.isNotEmpty ?? false
                          ? Image.asset(
                            widget.products?.image ?? "",
                            height: 80.h,
                            fit: BoxFit.fitHeight,
                          )
                          : CachedNetworkImage(
                            height: 80.h,
                            fit: BoxFit.fitHeight,
                            imageUrl:
                                widget.products?.image?.isNotEmpty ?? false
                                    ? widget.products?.image ?? ""
                                    : widget.products?.images?[index] ?? "",
                          ),
                );
              },
            ),
          ),

          /// Main Image
          20.responsiveHeight(),
          Expanded(
            child:
                widget.products?.image?.isNotEmpty ?? false
                    ? Image.asset(
                      widget.products?.image ?? "",
                      height: 300.h,
                      fit: BoxFit.fitWidth,
                    )
                    : CachedNetworkImage(
                      imageUrl: widget.products?.images?[0] ?? "",
                      height: 300.h,
                      fit: BoxFit.contain,
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorDot(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.black, width: 1.2),
      ),
    );
  }

  Widget _buildSizeBox(String size, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.black : Colors.grey.shade200,
      ),
      child: Text(
        size,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
