import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/appSettings.dart';
import 'package:shop_app/services/services.dart' show OrderService;
import 'package:shop_app/utils/extensions.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  const OrderItem({this.id, this.amount, this.products, this.date});

  OrderItem.fromJson(Map<String, dynamic> json, {String id})
      : this.id = id ?? json["name"],
        amount = json["amount"],
        date = json["date"],
        products = ((json["products"] as Map<String, dynamic> ?? {})
            .map(
                (key, value) => MapEntry(id, CartItem.fromJson(value, id: key)))
            .values
            .toList());

  OrderItem.copyWith(OrderItem value, {String id})
      : this.id = id,
        amount = value.amount,
        products = value.products,
        date = value.date;
}

class Order with ChangeNotifier {
  static const _service = const OrderService(AppSettings.serverAdress);

  List<OrderItem> _orders = [];

  List<OrderItem> get items => [..._orders];

  int get length => _orders.length;

  Future<OrderItem> add(List<CartItem> products, double total) async {
    var order = OrderItem(
        id: null, amount: total, products: products, date: DateTime.now());

    var result = await _service.post(orderItem: order);

    if (result.isNull) return null;

    order = OrderItem.copyWith(order, id: result.id);

    _orders.add(order);
    notifyListeners();
    return order;
  }
}
