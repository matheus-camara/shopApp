import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final int id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  const OrderItem({this.id, this.amount, this.products, this.date});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  var _nextId = 1;

  List<OrderItem> get items => [..._orders];

  void add(List<CartItem> products, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: _nextId,
            amount: total,
            products: products,
            date: DateTime.now()));

    _nextId++;
    notifyListeners();
  }
}
