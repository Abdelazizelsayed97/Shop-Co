import 'package:e_commerce_web_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_web_app/core/widgets/app_text_from.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/models/product_entity_model.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_styles.dart';
import '../managers/cart_cubit.dart';
import '../widgets/cart_card_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getUserCart("59b99dbbcfa9a34dcd7885c3"),
      child: _CartPageBody(),
    );
  }
}

class _CartPageBody extends StatefulWidget {
  @override
  State<_CartPageBody> createState() => _CartPageBodyState();
}

class _CartPageBodyState extends State<_CartPageBody> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _discountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state.fetchedCartProducts.isSuccess) {
          print(state.fetchedCartProducts.data);
        } else if (state.fetchedCartProducts.isFailure) {
          print(state.fetchedCartProducts.failureMessage);
        }
      },
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;

              return Scaffold(
                key: globalKey,
                appBar: AppBarWidget(
                  constraints: constraints,
                  globalKey: globalKey,
                ),
                body:
                    state.fetchedCartProducts.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                isWide
                                    ? MediaQuery.of(context).size.width * 0.05
                                    : 16.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              Text.rich(
                                TextSpan(
                                  text: "Home",
                                  children: [
                                    TextSpan(
                                      text: " > ",
                                      style: TextStyles.boldFont(),
                                    ),
                                    const TextSpan(
                                      text: "Cart",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "Your cart",
                                style: TextStyles.boldFont(fontSize: 36),
                              ),
                              SizedBox(height: 20.h),
                              Expanded(
                                child:
                                    isWide
                                        ? buildWebView(state)
                                        : buildMobileView(state),
                              ),
                            ],
                          ),
                        ),
              );
            },
          );
        },
      ),
    );
  }

  Row buildWebView(CartState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cart Product List
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: state.fetchedCartProducts.data?.length ?? 0,
              itemBuilder: (context, index) {
                if (state.fetchedCartProducts.data?[index].description ==
                    null) {
                  return SizedBox.shrink();
                }
                final product =
                    state.fetchedCartProducts.data?[index] ??
                    ProductEntityModel();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CartCardWidget(product: product),
                    if (index != state.fetchedCartProducts.data!.length - 1)
                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: const Divider(),
                      ),
                  ],
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
            ),
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(flex: 1, child: _buildTotalPriceSection),
      ],
    );
  }

  ListView buildMobileView(CartState state) {
    return ListView(
      shrinkWrap: true,
      children: [
        ...List.generate(state.fetchedCartProducts.data?.length ?? 0, (index) {
          if (state.fetchedCartProducts.data?[index].description == null) {
            return SizedBox.shrink();
          }
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: FittedBox(
              child: CartCardWidget(
                product:
                    state.fetchedCartProducts.data?[index] ??
                    ProductEntityModel(),
              ),
            ),
          );
        }),
        SizedBox(height: 24.h),
        _buildTotalPriceSection,
      ],
    );
  }

  Container get _buildTotalPriceSection {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Summary", style: TextStyles.boldFont(fontSize: 20)),
          const Divider(),
          ListTile(
            dense: true,
            title: Text(
              "Subtotal",
              style: TextStyles.regularFont(
                fontSize: 20,
                color: Colors.grey.shade500,
              ),
            ),
            trailing: Text("\$200", style: TextStyles.boldFont(fontSize: 20)),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Discount (-20%)",
              style: TextStyles.regularFont(
                fontSize: 20,
                color: Colors.grey.shade500,
              ),
            ),
            trailing: Text("-\$40", style: TextStyles.boldFont(fontSize: 20)),
          ),
          const Divider(),
          ListTile(
            dense: true,
            title: Text(
              "Total",
              style: TextStyles.regularFont(
                fontSize: 20,
                color: Colors.grey.shade500,
              ),
            ),
            trailing: Text("\$160", style: TextStyles.boldFont(fontSize: 20)),
          ),
          SizedBox(height: 24.h),
          AppTextFormField(
            controller: _discountController,
            validator: (p0) {},
            textHint: "Add promo code",

            icon: Icon(Iconsax.discount_shape),
          ),
          SizedBox(height: 24.h),
          AppPrimaryButton(
            onTap: () {
              context.go('/checkout');
            },
            isLoading: false,
            colors: AppColors.unFollowListColors,
            child: Text(
              "Checkout",
              style: TextStyles.mediumFont(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
