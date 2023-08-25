import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/screens/cart.dart';
import 'package:restaurant_app/screens/home.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get(BuildContext context) {
    return {
      HomeScreen.routeName: (context) => const HomeScreen(),
      CartScreen.routeName: (context) => const CartScreen(),

    };
  }
}