import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/review_entity.dart';
import 'package:e_commerce_web_app/features/home/ui/manager/cubit/home_cubit.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/dress_style_widget.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/product_body_widget.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/review_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/widgets/app_buttons.dart';
import '../widgets/app_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(),
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  final List<String> _categories = const [
    "Shop",
    "On Sale",
    "New Arrivals",
    "Brands",
  ];

  List<ProductEntity> products = [
    ProductEntity(
      id: "1",
      name: "T-SHIRT WITH TAPE DETAILS",
      description: "Description 1",
      price: 100.0,
      image: "lib/assets/images/product-1.png",
      rate: 4,
    ),
    ProductEntity(
      id: "2",
      name: "SKINNY FIT JEANS",
      description: "Description 2",
      price: 200.0,
      image: "lib/assets/images/product-2.png",
      rate: 5,
    ),
    ProductEntity(
      id: "3",
      name: "CHECKERED SHIRT",
      description: "Description 3",
      price: 300.0,
      image: "lib/assets/images/product-3.png",
      rate: 3,
    ),
    ProductEntity(
      id: "3",
      name: "SLEEVE STRIPED T-SHIRT",
      description: "Description 4",
      price: 300.0,
      image: "lib/assets/images/product-4.png",
      rate: 3,
    ),
  ];
  List<ReviewEntity> reviews = [
    ReviewEntity(
      id: "1",
      user: UserInfoEntity(fullName: "John Doe"),
      rate: 5,
      description: "This is a review",
    ),
    ReviewEntity(
      id: "2",
      user: UserInfoEntity(fullName: "John Doe"),
      rate: 5,
      description: "This is a review",
    ),
    ReviewEntity(
      id: "3",
      user: UserInfoEntity(fullName: "John Doe"),
      rate: 5,
      description: "This is a review",
    ),
    ReviewEntity(
      id: "4",
      user: UserInfoEntity(fullName: "John Doe"),
      rate: 5,
      description: "This is a review",
    ),
  ];

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
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.products.isSuccess) {
          products.addAll(state.products.data ?? []);
        } else if (state.products.isFailure) {
          print('Failure ${state.products.failureMessage}');
        }
      },
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
                      children: List.generate(_categories.length, (index) {
                        return ListTile(
                          title: Text(
                            _categories[index],
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
                            child: Center(child: CircularProgressIndicator()),
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
                                    )
                                    : SvgPicture.asset(
                                      "lib/assets/images/Group2.svg",
                                      width: constraints.maxWidth,
                                    ),
                                72.responsiveHeight(),
                                Text(
                                  "NEW ARRIVALS",
                                  style: TextStyles.boldFont(fontSize: 48.sp),
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
                                  style: TextStyles.boldFont(fontSize: 48.sp),
                                ),
                                54.responsiveHeight(),
                                Align(
                                  alignment: Alignment.center,
                                  child: ProductBodyWidget(products: products),
                                ),
                                36.responsiveHeight(),
                                OutlinedButton(
                                  onPressed: () {},
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
                                DressStyleWidget(),
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
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
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
                                          0.2,
                                    ),
                                    Positioned(
                                      top: -50.h,
                                      left: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                        ),
                                        child: Container(
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
                                              0.1,
                                          child: Row(children: []),
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
