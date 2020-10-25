import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});

  CartItem.fromJson(Map<String, dynamic> json, {String id})
      : this.id = id ?? json["name"],
        title = json["title"],
        quantity = json["quantity"],
        price = json["price"];
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get length => _items.length;

  double get total {
    var total = 0.0;
    _items.values.forEach((item) => total += item.price * item.quantity);
    return total;
  }

  void add({String productId, double price, String title}) {
    _items.containsKey(productId)
        ? _items.update(
            productId,
            (current) => CartItem(
                id: productId,
                price: price,
                title: title,
                quantity: current.quantity + 1))
        : _items.putIfAbsent(
            productId,
            () => CartItem(
                id: productId, price: price, title: title, quantity: 1));

    notifyListeners();
  }

  void addAll({Map<String, CartItem> values}) {
    _items.addAll(values);
    notifyListeners();
  }

  void remove(String id) {
    if (!items.containsKey(id)) return;

    if (_items[id].quantity > 1)
      _items.update(
          id,
          (current) => CartItem(
              id: current.id,
              price: current.price,
              title: current.title,
              quantity: current.quantity - 1));
    else
      _items.remove(id);

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
