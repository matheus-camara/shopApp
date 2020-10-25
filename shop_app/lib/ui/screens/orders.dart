import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/constants.dart';
import 'package:shop_app/providers/order.dart' show Order;
import 'package:shop_app/ui/widgets/drawer.dart';
import 'package:shop_app/ui/widgets/future_builder_with_loader.dart';
import 'package:shop_app/ui/widgets/order.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: APP_NAME,
        ),
        drawer: AppDrawer(),
        body: FutureBuilderWithLoader(
            future: Provider.of<Order>(context, listen: false).load(),
            builder: (context, snapshot) =>
                Consumer<Order>(builder: (context, provider, child) {
                  var items = provider.itemsOrderedByDateDesc();
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (ctx, i) => OrderItem(
                      order: items.elementAt(i),
                    ),
                  );
                })));
  }
}
