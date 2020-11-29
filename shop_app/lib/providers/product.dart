import 'package:flutter/foundation.dart';
import 'package:shop_app/appSettings.dart';
import 'package:shop_app/services/services.dart';
import 'package:shop_app/utils/extensions.dart';

class Product with ChangeNotifier {
  final String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;
  String _token;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  Product.fromJson(Map<String, dynamic> json, {String id})
      : this.id = id ?? json['name'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        imageUrl = json['imageUrl'],
        isFavorite = json['isFavorite'];

  Product.copyWith(Product product,
      {String id,
      String title,
      String description,
      double price,
      String imageUrl,
      bool isFavorite})
      : this.id = id ?? product.id,
        this.title = title ?? product.title,
        this.description = description ?? product.description,
        this.price = price ?? product.price,
        this.imageUrl = imageUrl ?? product.imageUrl,
        this.isFavorite = isFavorite ?? product.isFavorite;

  Product.empty()
      : this.id = null,
        this.description = "",
        this.imageUrl = "",
        this.price = 0,
        this.title = "",
        this.isFavorite = false;

  ProductService get service =>
      ProductService(AppSettings.serverAdress, _token);

  void setTitle(String title) => this.title = title;
  void setDescription(String description) => this.description = description;
  void setImageUrl(String imageUrl) => this.imageUrl = imageUrl;
  void setPrice(double price) => this.price = price;

  set favorite(bool favorite) {
    final oldStatus = isFavorite;
    isFavorite = favorite;

    service.patchMap(id: this.id, value: {"isFavorite": isFavorite}).then(
        (result) {
      if (result.isNull) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    });

    notifyListeners();
  }
}
