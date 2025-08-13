import 'package:e_commerce_web_app/features/home/ui/widgets/app_bar_widget.dart';
import 'package:e_commerce_web_app/features/products/ui/widgets/product_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/models/product_entity_model.dart';
import '../manager/product/product_cubit.dart';
import '../widgets/filer_side_widget.dart';

class ProductFilterPage extends StatelessWidget {
  const ProductFilterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: _ProductFilterPage(),
    );
  }
}

class _ProductFilterPage extends StatefulWidget {
  @override
  State<_ProductFilterPage> createState() => _ProductFilterPageState();
}

class _ProductFilterPageState extends State<_ProductFilterPage> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  final PagingController<int, ProductEntityModel> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context.read<ProductCubit>().fetchProducts("20", pageKey.toString());
    });
    super.initState();
  }

  void onDataLoaded(ProductState state) {
    var products = state.fetchProducts.data ?? [];
    if (products.isEmpty) {
      return;
    }
    if (products.length < 20) {
      _pagingController.appendLastPage(products);
      return;
    } else {
      _pagingController.appendPage(products, _pagingController.nextPageKey);
    }
    _pagingController.appendLastPage(products);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state.fetchProducts.isSuccess) {
          onDataLoaded(state);
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: AppBarWidget(
              constraints: constraints,
              globalKey: globalKey,
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [FilterSidebar()],
                  ),
                ),
                Flexible(flex: 1, child: Container()),
                Flexible(
                  flex: 7,
                  child: PagedGridView(
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 850 ? 3 : 2,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      // mainAxisExtent:getItemHeight(constraints, context)
                      // constraints.maxWidth > 850
                      //     ? MediaQuery.of(context).size.width * 0.35
                      //     : MediaQuery.of(context).size.height * 0.3,
                      childAspectRatio:
                          constraints.maxWidth > 1000
                              ? 1.75 / 2.7
                              : constraints.maxWidth > 850
                              ? 1.8 / 3.2
                              : 5 / 8.3,
                    ),
                    pagingController: _pagingController,
                    builderDelegate:
                        PagedChildBuilderDelegate<ProductEntityModel>(
                          itemBuilder: (context, item, index) {
                            return InkWell(
                              onTap: () {
                                context.push("/products");
                                // Get.to(
                                //
                                //   () => ProductDetailsPage(products: item),
                                //   popGesture: true,
                                //   routeName: "Product-$index",
                                // );
                              },
                              child: ProductItemBuilder(
                                product: item,
                                isLocal: false,
                              ),
                            );
                          },
                        ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
