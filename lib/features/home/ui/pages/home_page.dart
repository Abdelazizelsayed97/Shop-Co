import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:e_commerce_web_app/core/widgets/app_text_from.dart';
import 'package:e_commerce_web_app/features/home/data/static_data/static_data.dart';
import 'package:e_commerce_web_app/features/home/ui/manager/cubit/home_cubit.dart';
import 'package:e_commerce_web_app/features/home/ui/pages/product_filter_page.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/dress_style_widget.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/product_body_widget.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/review_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../widgets/app_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeCubit()
                ..getProducts()
                ..fetchDummyProducts(limit: 10.toString(), skip: 0.toString()),
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeCubit, HomeState>(
          listenWhen:
              (previous, current) => previous.products != current.products,
          listener: (context, state) {
            if (state.products.isSuccess) {
              fetchedProducts.addAll(state.products.data ?? []);
            } else if (state.products.isFailure) {
              print('Failure //${state.products.failureMessage}');
            }
          },
        ),
        BlocListener<HomeCubit, HomeState>(
          listenWhen:
              (previous, current) =>
                  previous.dummyProducts != current.dummyProducts,
          listener: (context, state) {
            if (state.dummyProducts.isSuccess) {
              print("new data ${state.dummyProducts.data}");
              fetchedpp.addAll(state.dummyProducts.data ?? []);
            }
          },
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.products.isFailure) {
            return Center(child: AppPrimaryButton(child: Text("Retry")));
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              return PopScope(
                canPop: false,
                child: Scaffold(
                  key: widget._key,
                  extendBody: false,
                  resizeToAvoidBottomInset: true,
                  extendBodyBehindAppBar: false,
                  drawer: Drawer(
                    backgroundColor: Colors.white,
                    child: Column(
                      children: List.generate(categories.length, (index) {
                        return ListTile(
                          title: Text(
                            categories[index],
                            style: TextStyles.boldFont(),
                          ),
                          onTap: () {
                            widget._key.currentState?.closeDrawer();
                          },
                        );
                      }),
                    ),
                  ),
                  appBar: AppBarWidget(
                    constraints: constraints,
                    globalKey: widget._key,
                  ),
                  body:
                      state.products.isLoading
                          ? Center(
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          )
                          : SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  constraints.maxWidth > 1050
                                      ? MediaQuery.of(context).size.width * .05
                                      : 0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                constraints.maxWidth > 950
                                    ? Image.asset(
                                      "lib/assets/images/group.png",
                                      width: constraints.maxWidth,
                                      fit: BoxFit.cover,
                                    )
                                    : Image.asset(
                                      "lib/assets/images/Group_mobile_view.png",
                                      width: constraints.maxWidth,
                                      fit: BoxFit.cover,
                                    ),
                                72.responsiveHeight(),
                                Text(
                                  "NEW ARRIVALS",
                                  style: TextStyles.boldFont(fontSize: 48),
                                  strutStyle: StrutStyle(
                                    forceStrutHeight: true,
                                    height: .6,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                55.responsiveHeight(),
                                Align(
                                  alignment: Alignment.center,
                                  child: ProductBodyWidget(products: products),
                                ),
                                152.responsiveHeight(),
                                Divider(),
                                64.responsiveHeight(),
                                Text(
                                  "TOP SELLING",
                                  style: TextStyles.boldFont(fontSize: 48),
                                ),
                                54.responsiveHeight(),
                                Align(
                                  alignment: Alignment.center,
                                  child: ProductBodyWidget(products: products),
                                ),
                                36.responsiveHeight(),
                                OutlinedButton(
                                  onPressed: () {
                                    Get.to(() {
                                      return ProductFilterPage(
                                        products: fetchedProducts,
                                      );
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.grey),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 120.w,
                                    child: Text(
                                      "View All",
                                      style: TextStyles.boldFont(fontSize: 16),
                                    ),
                                  ),
                                ),
                                40.responsiveHeight(),
                                constraints.maxWidth > 850
                                    ? DressStyleWidget()
                                    : Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: DressStyleWidget(),
                                    ),
                                80.responsiveHeight(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "OUR HAPPY CUSTOMERS",
                                    style: TextStyles.boldFont(fontSize: 64),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                64.responsiveHeight(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .1,
                                  child: ListView.builder(
                                    addAutomaticKeepAlives: true,
                                    shrinkWrap: true,
                                    itemCount: reviews.length,
                                    scrollDirection: Axis.horizontal,

                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                        ),
                                        child: ReviewCardWidget(
                                          review: reviews[index],
                                        ),
                                      );
                                    },
                                  ).animate().fadeIn(
                                    delay: Duration(seconds: 1),
                                    duration: Duration(seconds: 1),
                                  ),
                                ),
                                64.responsiveHeight(),
                                Stack(
                                  fit: StackFit.loose,
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.25,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.2,
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 24.w,
                                            vertical: 16.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(
                                              16.r,
                                            ),
                                          ),
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width -
                                              128.w,
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.15,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  right: 24.w,
                                                ),
                                                child: Text(
                                                  "STAY UPTO DATE ABOUT\n OUR LATEST OFFERS",
                                                  style: TextStyles.boldFont(
                                                    fontSize: 32,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),

                                              Flexible(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AppTextFormField(
                                                      controller:
                                                          TextEditingController(),
                                                      validator: (p0) {},
                                                      textHint:
                                                          "Enter your email address",
                                                      icon: Icon(
                                                        Icons.telegram_outlined,
                                                      ),
                                                    ),
                                                    AppPrimaryButton(
                                                      child: Text(
                                                        "Subscribe to Newsletter",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ).animate(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
