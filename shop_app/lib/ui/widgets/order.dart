import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/domain/constants.dart';
import 'package:shop_app/providers/order.dart' as providers;

class OrderItem extends StatelessWidget {
  final providers.OrderItem order;

  const OrderItem({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ExpansionTile(
              title: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.topLeft,
                child: Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(16),
                  label: Text(
                    "\$${order.amount}",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              subtitle: Text(DateFormat("$DATE_FORMAT_WITH_WEEKDAY hh:mm")
                  .format(order.date)),
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                  height: min(order.products.length * 30.0 + 20.0, 120),
                  child: ListView.builder(
                      itemCount: order.products.length,
                      itemBuilder: (ctx, index) {
                        final orderItem = order.products.elementAt(index);
                        return Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  orderItem.title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${orderItem.quantity}x \$${orderItem.price}",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                            const Divider()
                          ],
                        );
                      }),
                )
              ]),
        ],
      ),
    );
  }
}
