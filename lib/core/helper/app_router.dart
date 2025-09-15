import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/features/authentication/ui/manager/cubit/authentication_cubit.dart';
import 'package:e_commerce_web_app/features/authentication/ui/pages/login_page.dart';
import 'package:e_commerce_web_app/features/authentication/ui/pages/register_page.dart';
import 'package:e_commerce_web_app/features/cart/ui/pages/managers/cart_cubit.dart';
import 'package:e_commerce_web_app/features/cart/ui/pages/pages/checkout_page.dart';
import 'package:e_commerce_web_app/features/cart/ui/pages/pages/order_page.dart';
import 'package:e_commerce_web_app/features/home/ui/pages/home_page.dart';
import 'package:e_commerce_web_app/features/products/ui/manager/product/product_cubit.dart';
import 'package:e_commerce_web_app/features/products/ui/pages/product_filter_page.dart';
import 'package:e_commerce_web_app/features/products/ui/pages/product_page.dart';
import 'package:e_commerce_web_app/features/profile/ui/managers/orders_cubit.dart';
import 'package:e_commerce_web_app/features/profile/ui/pages/order_history_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/ui/pages/otp_page.dart';
import '../../features/cart/ui/pages/pages/cart_page.dart';
import '../../features/profile/ui/pages/profile_page.dart';

final _globalKey = GlobalKey<NavigatorState>();

void navigateTo(String route) {
  _globalKey.currentState!.pushNamed(route);
}

final GoRouter router = GoRouter(
  navigatorKey: _globalKey,
  initialLocation: '/',
  observers: [_MyNavigatorObserver()],
  routes: [
    GoRoute(
      path: '/',
      name: '/',
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: '/products',
      name: "/products",
      builder: (context, state) {
        // final data = state.extra as List<ProductEntityModel>;
        return ProductFilterPage();
      },
    ),
    GoRoute(
      path: '/login',
      name: "/login",
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: "/register",
      builder:
          (context, state) => BlocProvider(
            create: (context) => AuthenticationCubit(),
            child: RegisterPage(),
          ),
      name: "/register",
    ),
    GoRoute(
      path: "/cart/:userId",
      name: "/cart",
      builder:
          (context, state) =>
              CartPage(id: state.pathParameters["userId"] ?? ""),
    ),
    GoRoute(
      path: "/otp/:id",
      name: "/otp",
      builder: (context, state) {
        return OtpPage(
          email: state.extra as String,
          id: state.pathParameters["id"] as String,
        );
      },
    ),
    GoRoute(
      path: "/profile/:userId",
      name: "/profile",
      builder: (context, state) {
        final id = state.pathParameters["userId"];
        return ProfilePage(id: id ?? "");
      },
    ),
    GoRoute(
      path: "/product/:productId",
      name: "/product",
      builder: (context, state) {
        final productId = state.pathParameters['productId']!;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
            BlocProvider(create: (context) => CartCubit()),
          ],
          child: ProductDetailsPage(productId: productId),
        );
      },
    ),
    GoRoute(
      path: "/order/:id",
      name: "/order",
      builder: (context, state) => OrderPage(),
    ),
    GoRoute(
      path: "/order-history",
      name: "/order-history",
      builder:
          (context, state) => BlocProvider(
            create: (context) => OrdersCubit(),
            child: const OrderHistoryPage(),
          ),
    ),
    GoRoute(
      path: "/checkout",
      name: "/checkout",
      builder:
          (context, state) =>
              CheckoutPage(products: state.extra as List<ProductEntityModel>),
    ),
  ],
);

class _MyNavigatorObserver extends NavigatorObserver {
  final List<String> _routeHistory = [];

  List<String> get routeHistory => List.unmodifiable(_routeHistory);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name;
    if (routeName != null) {
      _routeHistory.add(routeName);
      debugPrint('Pushed route: $routeName, History: $_routeHistory');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name;
    if (_routeHistory.isNotEmpty && routeName != null) {
      if (routeName == _routeHistory.last) {
        _routeHistory.removeLast();
      } else if (_routeHistory.isNotEmpty) {
        _routeHistory.add("/");
      } else {
        _routeHistory.remove(routeName);
      }
      debugPrint('Popped route: $routeName, History: $_routeHistory');
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final newRouteName = newRoute?.settings.name;
    if (newRouteName != null && _routeHistory.isNotEmpty) {
      _routeHistory[_routeHistory.length - 1] = newRouteName;
      debugPrint('Replaced route: $newRouteName, History: $_routeHistory');
    } else if (newRouteName != null) {
      _routeHistory.add(newRouteName);
      debugPrint(
        'Replaced (added) route: $newRouteName, History: $_routeHistory',
      );
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name;
    if (routeName != null) {
      _routeHistory.removeWhere((path) => path == routeName);
      debugPrint('Removed route: $routeName, History: $_routeHistory');
    }
  }
}

//
// final _globalKey = GlobalKey<NavigatorState>();
//
// void navigateTo(String route) {
//   _globalKey.currentState!.pushNamed(route);
// }
//
//  GoRouter router = GoRouter(
//   navigatorKey: _globalKey,
//   initialLocation: '/',
//   observers: [_MyNavigatorObserver()],
//   routes: [
//     GoRoute(
//       path: '/',
//       name: '/',
//       builder: (context, state) {
//         return HomePage();
//       },
//     ),
//     GoRoute(
//       path: '/products',
//       name: "/products",
//       builder: (context, state) {
//         // final data = state.extra as List<ProductEntityModel>;
//         return ProductFilterPage();
//       },
//     ),
//     GoRoute(
//       path: '/login',
//       name: "/login",
//       builder: (context, state) {
//         return const LoginPage();
//       },
//     ),
//     GoRoute(
//       path: "/register",
//       builder:
//           (context, state) => BlocProvider(
//             create: (context) => AuthenticationCubit(),
//             child: RegisterPage(),
//           ),
//       name: "/register",
//     ),
//     GoRoute(
//       path: "/cart/:userId",
//       name: "/cart",
//       builder:
//           (context, state) =>
//               CartPage(id: state.pathParameters["userId"] ?? ""),
//     ),
//     GoRoute(
//       path: "/otp/:id",
//       name: "/otp",
//       builder: (context, state) {
//         return OtpPage(
//           email: state.extra as String,
//           id: state.pathParameters["id"] as String,
//         );
//       },
//     ),
//     GoRoute(
//       path: "/profile/:userId",
//       name: "/profile",
//       builder: (context, state) {
//         final id = state.pathParameters["userId"];
//         return ProfilePage(id: id ?? "");
//       },
//     ),
//     GoRoute(
//       path: "/product/:productId",
//       name: "/product",
//       builder: (context, state) {
//         final productId = state.pathParameters['productId']!;
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider(create: (context) => ProductCubit()),
//             BlocProvider(create: (context) => CartCubit()),
//           ],
//           child: ProductDetailsPage(productId: productId),
//         );
//       },
//     ),
//     GoRoute(
//       path: "/order/:id",
//       name: "/order",
//       builder: (context, state) => OrderPage(),
//     ),
//   ],
// );
//
// class _MyNavigatorObserver extends NavigatorObserver {
//   final List<String> _routeHistory = [];
//
//   List<String> get routeHistory => List.unmodifiable(_routeHistory);
//
//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     final routeName = route.settings.name;
//     if (routeName != null) {
//       _routeHistory.add(routeName);
//       debugPrint('Pushed route: $routeName, History: $_routeHistory');
//     }
//   }
//
//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     final routeName = route.settings.name;
//     if (_routeHistory.isNotEmpty && routeName != null) {
//       if (routeName == _routeHistory.last) {
//         _routeHistory.removeLast();
//       } else if (_routeHistory.isNotEmpty) {
//         _routeHistory.add("/");
//       } else {
//         _routeHistory.remove(routeName);
//       }
//       debugPrint('Popped route: $routeName, History: $_routeHistory');
//     }
//   }
//
//   @override
//   void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
//     final newRouteName = newRoute?.settings.name;
//     if (newRouteName != null && _routeHistory.isNotEmpty) {
//       _routeHistory[_routeHistory.length - 1] = newRouteName;
//       debugPrint('Replaced route: $newRouteName, History: $_routeHistory');
//     } else if (newRouteName != null) {
//       _routeHistory.add(newRouteName);
//       debugPrint(
//         'Replaced (added) route: $newRouteName, History: $_routeHistory',
//       );
//     }
//   }
//
//   @override
//   void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     final routeName = route.settings.name;
//     if (routeName != null) {
//       _routeHistory.removeWhere((path) => path == routeName);
//       debugPrint('Removed route: $routeName, History: $_routeHistory');
//     }
//   }
// }
