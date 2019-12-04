import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/ui/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final showOnlyFavorites;

  const ProductsGrid({Key key, this.showOnlyFavorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context);
    final products = showOnlyFavorites ? provider.favorites : provider.products;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products.elementAt(index),
        child: ProductItem(),
      ),
    );
  }
}
