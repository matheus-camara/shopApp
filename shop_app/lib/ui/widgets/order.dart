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
          ListTile(
            title: Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.topLeft,
              child: Chip(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(12),
                label: Text(
                  "\$${order.amount}",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            subtitle: Text(DateFormat("$DEFAULT_DATE_FORMAT hh:mm")
                .format(order.date)
                .toString()),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () => null,
            ),
          )
        ],
      ),
    );
  }
}
