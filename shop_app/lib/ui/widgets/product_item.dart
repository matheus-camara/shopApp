import 'package:flutter/material.dart';
import 'package:shop_app/domain/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.fill,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () => null,
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => null,
        ),
      ),
    );
  }
}
