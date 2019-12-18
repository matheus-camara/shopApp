import 'package:flutter/widgets.dart';
import 'package:shop_app/ui/screens/cart.dart';
import 'package:shop_app/ui/screens/orders.dart';
import 'package:shop_app/ui/screens/product_detail.dart';
import 'package:shop_app/ui/screens/products_overview.dart';
import 'package:shop_app/ui/screens/user_products.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
  ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
  CartScreen.routeName: (ctx) => CartScreen(),
  OrdersScreen.routeName: (ctx) => OrdersScreen(),
  UserProductsScreen.routeName: (ctx) => UserProductsScreen()
};
