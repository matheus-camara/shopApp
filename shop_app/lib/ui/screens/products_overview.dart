import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/constants.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/ui/screens/cart.dart';
import 'package:shop_app/ui/widgets/badge.dart';
import 'package:shop_app/ui/widgets/drawer.dart';
import 'package:shop_app/ui/widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = "/products";
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: APP_NAME,
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) => setState(() =>
                _showOnlyFavorites = selectedValue == FilterOptions.Favorites),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text("Only favorites"),
                value: FilterOptions.Favorites,
              ),
              const PopupMenuItem(
                child: Text("Show all"),
                value: FilterOptions.All,
              )
            ],
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.length.toString(),
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(
        showOnlyFavorites: _showOnlyFavorites,
      ),
    );
  }
}
