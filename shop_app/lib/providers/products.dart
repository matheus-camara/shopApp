import 'package:flutter/material.dart';
import 'package:shop_app/appSettings.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/services/services.dart' show ProductService;
import 'package:shop_app/utils/extensions.dart';

class Products with ChangeNotifier {
  ProductService get service => ProductService(AppSettings.serverAdress, token);

  String token;

  Products(this.token);

  List<Product> _products = [];

  List<Product> get items => [..._products];

  int get length => _products.length;

  List<Product> get favorites => [...items.where((p) => p.isFavorite)];

  Product find(String id) => items.firstWhere((p) => p.id == id);

  Future<void> delete(String id) async {
    var found = find(id);

    if (found.isNull) return;

    _products.remove(found);
    await service.delete(product: found);
    notifyListeners();
  }

  Future<Product> add(Product value) async {
    var result = await service.post(product: value);

    if (result.isNull) return null;

    _products.add(Product.copyWith(value, id: result.id));
    notifyListeners();

    return result;
  }

  Future<Product> update(Product value) async {
    var foundIndex = _products.indexWhere((element) => element.id == value.id);
    if (foundIndex < 0) return null;

    var item = _products.removeAt(foundIndex);

    var updated = Product.copyWith(item,
        id: value.id,
        description: value.description,
        imageUrl: value.imageUrl,
        isFavorite: value.isFavorite,
        price: value.price,
        title: value.title);

    var result = await service.patch(product: updated);
    if (result.isNull) return null;

    _products.add(result);
    notifyListeners();
    return result;
  }

  Future<void> load() async {
    if (_products.isEmpty) _products.addAll((await service.get()));
  }

  Future<void> fetch({String id}) async {
    _products = await service.get();
    notifyListeners();
  }

  Future<Product> fetchOne(String id) async {
    return await service.fetch(id);
  }
}
