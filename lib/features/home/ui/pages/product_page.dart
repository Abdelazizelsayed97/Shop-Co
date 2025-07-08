import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/dummy_product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, this.products, this.dummyProducts});
  final ProductEntity? products;
  final DummyProductEntity? dummyProducts;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    final images = [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 1000;
              return Flex(
                direction: isWide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Left side - images
                  Flexible(
                    flex: 2,
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
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                    width: index == 0 ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      widget.products?.image?.isNotEmpty ??
                                              false
                                          ? widget.products?.image ?? ""
                                          : widget.products?.images?[index] ??
                                              "",
                                  height: 80,

                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),

                        /// Main Image
                        const SizedBox(width: 20),
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl:
                                widget.products?.image?.isNotEmpty ?? false
                                    ? widget.products?.image ?? ""
                                    : widget.products?.images?[0] ?? "",
                            height: 400,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: isWide ? 40 : 0, height: isWide ? 0 : 30),

                  /// Right side - details
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ONE LIFE GRAPHIC T-SHIRT',
                          style: TextStyle(
                            fontSize: 34.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

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
                            const SizedBox(width: 8),
                            const Text('4.5/5'),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// Price
                        Row(
                          children: [
                            Text(
                              '\$260',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '\$300',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        const Text(
                          'This graphic t-shirt which is perfect for any occasion. Crafted from a soft and breathable fabric, it offers superior comfort and style.',
                        ),

                        const SizedBox(height: 20),

                        /// Colors
                        const Text('Select Colors'),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildColorDot(Colors.brown),
                            _buildColorDot(Colors.green),
                            _buildColorDot(Colors.blue),
                            _buildColorDot(Colors.black),
                          ],
                        ),

                        const SizedBox(height: 20),
                        const Text('Choose Size'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          children: [
                            _buildSizeBox('Small'),
                            _buildSizeBox('Medium'),
                            _buildSizeBox('Large', isSelected: true),
                            _buildSizeBox('X-Large'),
                          ],
                        ),

                        const SizedBox(height: 20),
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
