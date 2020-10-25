import 'package:flutter/material.dart';
import 'package:shop_app/appSettings.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/services/services.dart';
import 'package:shop_app/ui/widgets/drawer.dart';
import 'package:shop_app/ui/widgets/future_builder_with_loader.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail";

  static const _service = const ProductService(AppSettings.serverAdress);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

    return FutureBuilderWithLoader<Product>(
      future: _service.fetch(productId),
      needScaffold: true,
      builder: (ctx, product) {
        return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          drawer: AppDrawer(),
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "\$${product.price}",
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
