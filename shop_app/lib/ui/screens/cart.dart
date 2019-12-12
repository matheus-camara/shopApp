import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/constants.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/ui/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: APP_NAME,
        ),
        body: Consumer<Cart>(
            builder: (_, cart, child) => Column(children: <Widget>[
                  Card(
                      margin: const EdgeInsets.all(15),
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Total",
                                style: TextStyle(fontSize: 20),
                              ),
                              const Spacer(),
                              Chip(
                                backgroundColor: _theme.primaryColor,
                                label: Text(
                                  "\$${cart.total}",
                                  style: _theme.primaryTextTheme.title,
                                ),
                              ),
                              Consumer<Order>(
                                builder: (_, order, child) => FlatButton(
                                  child: const Text("Order"),
                                  onPressed: () {
                                    order.add(
                                        cart.items.values.toList(), cart.total);
                                    cart.clear();
                                  },
                                  textColor: _theme.primaryColor,
                                ),
                              ),
                            ],
                          ))),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (bctx, i) {
                          final item = cart.items.values.toList().elementAt(i);
                          return CartItem(
                              id: item.id,
                              price: item.price,
                              quantity: item.quantity,
                              title: item.title);
                        }),
                  )
                ])));
  }
}
