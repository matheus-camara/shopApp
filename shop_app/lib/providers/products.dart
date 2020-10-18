import 'package:flutter/material.dart';
import 'package:shop_app/appSettings.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/services/services.dart' show ProductService;
import 'package:shop_app/utils/extensions.dart';

class Products with ChangeNotifier {
  static const ProductService _service =
      const ProductService(AppSettings.serverAdress);

  List<Product> _products = [];

  List<Product> get items => [..._products];

  int get length => _products.length;

  List<Product> get favorites => [...items.where((p) => p.isFavorite)];

  Product find(String id) => items.firstWhere((p) => p.id == id);

  Future<void> delete(String id) async {
    var found = find(id);

    if (found.isNull) return;

    _products.remove(found);
    await _service.delete(product: found);
    notifyListeners();
  }

  Future<Product> add(Product value) async {
    var result = await _service.post(product: value);

    if (result.isNull) return null;

    _products.add(Product.copyWith(value, id: result.id));
    notifyListeners();

    return result;
  }

  Future<Product> update(Product value) async {
    var found = _products.firstWhere((element) => element.id == value.id);
    if (found.isNull) return null;

    _products.removeWhere((element) => element.id == value.id);

    var updated = Product.copyWith(found,
        id: value.id,
        description: value.description,
        imageUrl: value.imageUrl,
        isFavorite: value.isFavorite,
        price: value.price,
        title: value.title);

    var result = await _service.patch(product: updated);
    if (result.isNull) return null;

    _products.add(result);
    notifyListeners();
    return result;
  }

  Future<void> load() async {
    if (_products.isEmpty) _products.addAll((await _service.get()));
  }

  Future<void> fetch() async {
    _products = await _service.get();
    notifyListeners();
  }
}
