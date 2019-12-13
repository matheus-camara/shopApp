import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/domain/constants.dart';
import 'package:shop_app/providers/order.dart' as providers;

class OrderItem extends StatefulWidget {
  final providers.OrderItem order;

  const OrderItem({Key key, this.order}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

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
                  "\$${widget.order.amount}",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            subtitle: Text(DateFormat("$DEFAULT_DATE_FORMAT hh:mm")
                .format(widget.order.date)
                .toString()),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => _expanded = !_expanded),
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              height: min(widget.order.products.length * 20.0 + 10.0, 120),
              child: ListView(
                children: widget.order.products
                    .map((p) => Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  p.title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${p.quantity}x \$${p.price}",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                            const Divider()
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
