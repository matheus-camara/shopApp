import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/constants.dart';
import 'package:shop_app/providers/order.dart' show Order;
import 'package:shop_app/ui/widgets/drawer.dart';
import 'package:shop_app/ui/widgets/order.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Order>(context);
    final orders = provider.items;
    return Scaffold(
      appBar: AppBar(
        title: APP_NAME,
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (ctx, i) => OrderItem(
          order: orders.elementAt(i),
        ),
      ),
    );
  }
}
