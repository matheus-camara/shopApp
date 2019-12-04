import 'package:flutter/widgets.dart';
import 'package:shop_app/ui/screens/product_detail.dart';

class Router {
  static final Map<String, Widget Function(BuildContext)> routes = {
    ProductDetailScreen.routeName: (ctx) => ProductDetailScreen()
  };
}
