import 'package:flutter/foundation.dart';

class CartItem {
  final int id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<int, CartItem> _items;

  Map<int, CartItem> get items => {..._items};

  void add({int productId, double price, String title}) => _items
          .containsKey(productId)
      ? _items.update(
          productId,
          (current) => CartItem(
              id: productId,
              price: price,
              title: title,
              quantity: current.quantity + 1))
      : _items.putIfAbsent(
          productId,
          () =>
              CartItem(id: productId, price: price, title: title, quantity: 1));
}
