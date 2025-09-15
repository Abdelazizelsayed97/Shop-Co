import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/features/cart/ui/pages/managers/cart_cubit.dart';
import 'package:e_commerce_web_app/features/products/ui/widgets/color_dot.dart';
import 'package:e_commerce_web_app/features/products/ui/widgets/image_preview_section.dart';
import 'package:e_commerce_web_app/features/products/ui/widgets/size_box.dart';
import 'package:e_commerce_web_app/features/products/ui/widgets/tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductEntityModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _size = ['S', 'M', 'L', 'XL', 'XXL'];
  String? _selectedSize;
  int _quantity = 1;
  Color? _selectedColor;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;

        return SingleChildScrollView(
          padding:
              isWide
                  ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .1,
                  )
                  : EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
          child: Flex(
            direction: isWide ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ImagePreviewSection(images: widget.product.images ?? []),
              SizedBox(width: isWide ? 40.w : 0, height: isWide ? 0 : 30.h),
              Flexible(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name ?? 'ONE LIFE GRAPHIC T-SHIRT',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        StarRating(
                          rating: widget.product.rating ?? 0,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.product.rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          '${widget.product.price.toString()}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.product.description ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Select Colors',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ColorDot(
                          color: Colors.brown,
                          isSelected: _selectedColor == Colors.brown,
                        ),
                        ColorDot(
                          color: Colors.green,
                          isSelected: _selectedColor == Colors.green,
                        ),
                        ColorDot(
                          color: Colors.blue,
                          isSelected: _selectedColor == Colors.blue,
                        ),
                        ColorDot(
                          color: Colors.black,
                          isSelected: _selectedColor == Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Choose Size',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.start,
                      children:
                          _size.map((sizeValue) {
                            bool isCurrentlySelected =
                                _selectedSize == sizeValue;
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedSize = sizeValue;
                                });
                              },
                              child: SizeBox(
                                sizeText: sizeValue,
                                isSelected: isCurrentlySelected,
                              ),
                            );
                          }).toList(),
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
                                onPressed: () {
                                  setState(() {
                                    if (_quantity > 1) {
                                      _quantity--;
                                    }
                                  });
                                },
                              ),
                              Text(_quantity.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        BlocListener<CartCubit, CartState>(
                          listener: (context, state) {
                            if (state.addToCart.isSuccess) {
                              context.read<CartCubit>().getUserCart(
                                widget.product.id.toString(),
                              );
                            } else if (state.addToCart.isFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Something went wrong'),
                                ),
                              );
                            }
                          },
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<CartCubit>().addToCart(
                                widget.product.id.toString(),
                              );
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ProductTabBarView(
                      tabController: _tabController,
                      description: widget.product.description ?? "",
                      reviews: [],
                      // reviews: widget.product.reviews ?? [],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
