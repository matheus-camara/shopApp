import 'package:flutter/material.dart';
import 'package:shop_app/domain/constants.dart';
import 'package:shop_app/domain/product.dart';
import 'package:shop_app/mocks/products.dart';
import 'package:shop_app/ui/widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = PRODUCTS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Constants.appName,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, index) =>
            ProductItem(product: loadedProducts.elementAt(index)),
      ),
    );
  }
}
