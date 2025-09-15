import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/app_bar_widget.dart';
import 'package:e_commerce_web_app/features/products/ui/manager/product/product_cubit.dart';
import 'package:e_commerce_web_app/features/products/ui/widgets/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.productId});
  final String productId;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBarWidget(
                constraints: constraints,
                globalKey: GlobalKey(),
              ),
              body: SafeArea(
                child:
                    state.productDetails.isSuccess
                        ? ProductDetailsView(
                          product:
                              state.productDetails.data ?? ProductEntityModel(),
                        )
                        : const Center(child: CircularProgressIndicator()),
                // child: state.productDetails.(
                //   initial: () => const SizedBox.shrink(),
                //   loading: () => const Center(child: CircularProgressIndicator()),
                //   success: (product) => ProductDetailsView(product: product!),
                //   failure: (message) => Center(child: Text(message)),
                // ),
              ),
            );
          },
        );
      },
    );
  }
}
