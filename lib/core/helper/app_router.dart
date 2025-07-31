import 'package:e_commerce_web_app/features/authentication/ui/manager/cubit/authentication_cubit.dart';
import 'package:e_commerce_web_app/features/authentication/ui/pages/login_page.dart';
import 'package:e_commerce_web_app/features/authentication/ui/pages/register_page.dart';
import 'package:e_commerce_web_app/features/home/ui/pages/home_page.dart';
import 'package:e_commerce_web_app/features/home/ui/pages/product_filter_page.dart';
import 'package:e_commerce_web_app/features/home/ui/pages/product_page.dart';
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
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) {
        // final data = state.extra as List<ProductEntityModel>;
        return ProductFilterPage();
      },
    ),
    GoRoute(
      path: '/login',
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
    GoRoute(path: "/cart", builder: (context, state) => CartPage()),
    GoRoute(path: "/otp/:email", builder: (context, state) => OtpPage()),
    GoRoute(path: "/profile", builder: (context, state) => ProfilePage()),
    GoRoute(
      path: "/product",
      builder: (context, state) => ProductDetailsPage(),
    ),
  ],
);

class _MyNavigatorObserver extends NavigatorObserver {
  // This list will store the history of route paths.
  final List<String> _routeHistory = [];

  List<String> get routeHistory => List.unmodifiable(_routeHistory);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      _routeHistory.add(route.settings.name!);
      debugPrint(
        'Pushed route: ${route.settings.name}, History: $_routeHistory',
      );
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (_routeHistory.isNotEmpty) {
      _routeHistory.removeLast();
      debugPrint(
        'Popped route: ${route.settings.name}, History: $_routeHistory',
      );
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute?.settings.name != null && _routeHistory.isNotEmpty) {
      _routeHistory[_routeHistory.length - 1] = newRoute!.settings.name!;
      debugPrint(
        'Replaced route: ${newRoute.settings.name}, History: $_routeHistory',
      );
    } else if (newRoute?.settings.name != null) {
      _routeHistory.add(newRoute!.settings.name!);
      debugPrint(
        'Replaced (added) route: ${newRoute.settings.name}, History: $_routeHistory',
      );
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      _routeHistory.removeWhere((path) => path == route.settings.name);
      debugPrint(
        'Removed route: ${route.settings.name}, History: $_routeHistory',
      );
    }
  }
}
