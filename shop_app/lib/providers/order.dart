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
        date = json["date"] == null ? null : DateTime.parse(json["date"]),
        products = ((json["products"] as List<dynamic> ?? {})
            .map((value) => CartItem.fromJson(value, id: value["id"]))
            .toList());

  OrderItem.copyWith(OrderItem value, {String id})
      : this.id = id,
        amount = value.amount,
        products = value.products,
        date = value.date;
}

class Order with ChangeNotifier {
  String _token;

  Order(this._token);

  List<OrderItem> _orders = [];

  List<OrderItem> get items => [..._orders];

  List<OrderItem> itemsOrderedByDateDesc() {
    var result = items;
    result.sort((x, y) => y.date.compareTo(x.date));
    return result;
  }

  OrderService get service => OrderService(AppSettings.serverAdress, _token);

  int get length => _orders.length;

  Future<void> load() async {
    if (_orders.isEmpty) _orders.addAll((await service.get()));
  }

  Future<void> fetch() async {
    _orders = await service.get();
    notifyListeners();
  }

  Future<OrderItem> add(List<CartItem> products, double total) async {
    var order = OrderItem(
        id: null, amount: total, products: products, date: DateTime.now());

    var result = await service.post(orderItem: order);

    if (result.isNull) return null;

    order = OrderItem.copyWith(order, id: result.id);

    _orders.add(order);
    notifyListeners();
    return order;
  }

  Future<bool> delete(String id) async {
    _orders.removeWhere((element) => element.id == id);

    var response = await service.delete(id: id);

    return response.isNotNull;
  }
}
