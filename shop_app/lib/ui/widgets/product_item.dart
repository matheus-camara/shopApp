import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/ui/screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _navigator = Navigator.of(context);
    final _product = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => _navigator.pushNamed(ProductDetailScreen.routeName,
              arguments: _product.id),
          child: Image.network(
            _product.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black12,
          leading: IconButton(
            icon: Icon(
                _product.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () => _product.toogleFavorite(),
            color: _theme.accentColor,
          ),
          title: Text(
            _product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => null,
            color: _theme.accentColor,
          ),
        ),
      ),
    );
  }
}
