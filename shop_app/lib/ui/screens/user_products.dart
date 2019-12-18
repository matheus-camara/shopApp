import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/ui/widgets/drawer.dart';
import 'package:shop_app/ui/widgets/user_product.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-products";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Products"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => null,
            )
          ],
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Consumer<Products>(
            builder: (ctx, products, child) => ListView.separated(
              separatorBuilder: (_, index) => Divider(),
              itemCount: products.items.length,
              itemBuilder: (_, index) => UserProductItem(
                title: products.items.elementAt(index).title,
                imageUrl: products.items.elementAt(index).imageUrl,
              ),
            ),
          ),
        ));
  }
}
