import 'dart:html' as html;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/utils/app_colors.dart';
import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/text_styles.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, this.product});
  final ProductEntityModel? product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  final List<String> _size = ['S', 'M', 'L', 'XL', 'XXL'];
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    html.window.history.pushState({}, '', '/new-path');
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarWidget(constraints: constraints, globalKey: globalKey),
          body: SafeArea(
            child: SingleChildScrollView(
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
                  _buildImagePreviewSection,
                  SizedBox(width: isWide ? 40.w : 0, height: isWide ? 0 : 30.h),
                  Flexible(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product?.name ?? 'ONE LIFE GRAPHIC T-SHIRT',
                          style: TextStyles.boldFont(fontSize: 18),
                        ),
                        12.responsiveHeight(),

                        Row(
                          children: [
                            StarRating(
                              rating: widget.product?.rating ?? 0,
                              color: Colors.orange,
                            ),
                            8.responsiveWidth(),
                            Text(
                              widget.product?.rating.toString() ?? "",
                              style: TextStyles.regularFont(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        20.responsiveHeight(),
                        Row(
                          children: [
                            Text(
                              widget.product?.price.toString() ?? "",
                              style: TextStyles.boldFont(fontSize: 18),
                            ),
                            12.responsiveWidth(),
                          ],
                        ),
                        16.responsiveHeight(),

                        Text(
                          widget.product?.description ?? "",
                          style: TextStyles.regularFont(fontSize: 14),
                        ),
                        16.responsiveHeight(),

                        Text('Select Colors', style: TextStyles.mediumFont()),
                        8.responsiveHeight(),
                        Row(
                          children: [
                            _buildColorDot(Colors.brown),
                            _buildColorDot(Colors.green),
                            _buildColorDot(Colors.blue),
                            _buildColorDot(Colors.black),
                          ],
                        ),
                        20.responsiveHeight(),

                        const Text('Choose Size'),
                        8.responsiveHeight(),

                        Wrap(
                          spacing: 12.w,
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
                                  child: _buildSizeBox(
                                    sizeValue,
                                    isSelected: isCurrentlySelected,
                                  ),
                                );
                              }).toList(),
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
                              child: Text(
                                'Add to Cart',
                                style: TextStyles.mediumFont(
                                  color: AppColors.appBackGroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// TAB BAR SECTION
                        SizedBox(height: 30),
                        _buildTabBarView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Flexible get _buildImagePreviewSection {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: List.generate(widget.product?.images?.length ?? 0, (
              index,
            ) {
              final image = widget.product?.images?[index] ?? "";
              final isNetwork = image.contains("http");

              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: index == 0 ? 2 : 1,
                  ),
                  // borderRadius: BorderRadius.circular(8.r),
                ),
                child:
                    isNetwork
                        ? CachedNetworkImage(
                          height: 80.h,
                          width: 80.w,
                          fit: BoxFit.fitHeight,
                          imageUrl: image,
                          errorWidget: (context, url, error) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: Icon(
                                Iconsax.warning_2,
                                color: Colors.black,
                              ),
                            );
                          },
                        )
                        : Image.asset(
                          image,
                          height: 80.h,
                          fit: BoxFit.fitHeight,
                        ),
              );
            }),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .01),
          Expanded(
            child:
                (widget.product?.images?.isNotEmpty ?? false)
                    ? CachedNetworkImage(
                      imageUrl: widget.product?.images?.first ?? "",
                      // height: 300.h,
                      width: MediaQuery.of(context).size.width * .15,
                      fit: BoxFit.fitWidth,
                      errorWidget: (context, url, error) {
                        return Container(
                          color: Colors.grey.shade200,
                          height: 400.h,
                          width: 300.w,
                          child: Icon(Iconsax.warning_2, color: Colors.black),
                        );
                      },
                    )
                    : const SizedBox.shrink(),
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

  Widget _buildSizeBox(String sizeText, {required bool isSelected}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.black,
          width: 1.5,
        ),
      ),
      child: Text(
        sizeText,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "Details", icon: Icon(Iconsax.info_circle)),
            Tab(text: "Reviews", icon: Icon(Icons.reviews_outlined)),
          ],
        ),
        SizedBox(
          height: 200.h,
          child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0.w,
                  vertical: 12.h,
                ),
                child: Text(
                  widget.product?.description ?? "No description",
                  style: TextStyles.mediumFont(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0.w,
                  vertical: 12.h,
                ),
                child: Text(
                  "Customer reviews will go here.",
                  style: TextStyles.mediumFont(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
