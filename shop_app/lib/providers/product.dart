import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

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

  set favorite(bool favorite) {
    isFavorite = favorite;
    notifyListeners();
  }
}
