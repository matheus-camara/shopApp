import 'package:flutter/material.dart';
import 'package:shop_app/mocks/products.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _products = productsData;

  List<Product> get items => [..._products];

  List<Product> get favorites => [...items.where((p) => p.isFavorite)];

  void add(Product value) {
    _products.add(value);
    notifyListeners();
  }

  Product find(int id) => items.firstWhere((p) => p.id == id);
}
