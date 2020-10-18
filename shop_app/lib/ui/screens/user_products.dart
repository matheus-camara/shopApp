import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/ui/screens/edit_product.dart';
import 'package:shop_app/ui/widgets/drawer.dart';
import 'package:shop_app/ui/widgets/user_product.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-products";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Products"),
        ),
        drawer: AppDrawer(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () =>
              Navigator.of(context).pushNamed(EditProductScreen.routeName),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Consumer<Products>(
            builder: (ctx, products, child) => RefreshIndicator(
              onRefresh: () async => await products.fetch(),
              child: ListView.separated(
                  separatorBuilder: (_, index) => Divider(),
                  itemCount: products.items.length,
                  itemBuilder: (_, index) {
                    var found = products.items.elementAt(index);
                    return UserProductItem(
                      id: found.id,
                      title: found.title,
                      imageUrl: found.imageUrl,
                    );
                  }),
            ),
          ),
        ));
  }
}
