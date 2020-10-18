import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/product.dart';

abstract class ServiceBase {
  final String _baseUrl;

  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };

  const ServiceBase(this._baseUrl);

  Future<http.Response> _post<T>({String url, @required T data}) =>
      http.post(_routeBuilder(url), body: json.encode(data), headers: headers);

  Future<http.Response> _patch<T>({String url, @required T data}) =>
      http.patch(_routeBuilder(url), body: json.encode(data));

  Future<http.Response> _delete({String url}) =>
      http.delete(_routeBuilder(url));

  Future<http.Response> _get({String url, Map<String, String> params}) =>
      http.get(_routeBuilder(url, params: params));

  String _routeBuilder(String url, {Map<String, String> params}) {
    if (params != null && params.isNotEmpty) {
      return Uri(path: "$_baseUrl/$url", queryParameters: params).toString();
    }

    return "$_baseUrl/$url";
  }
}

class ProductService extends ServiceBase {
  const ProductService(String baseUrl) : super(baseUrl);
  Map<String, dynamic> productToMap(Product product) => {
        "title": product.title,
        "price": product.price,
        "description": product.description,
        "imageUrl": product.imageUrl,
      };

  Future<Product> post({@required Product product}) async {
    try {
      var response =
          await this._post(url: "products.json", data: productToMap(product));

      if (response.statusCode == HttpStatus.ok) {
        var product = Product.fromJson(json.decode(response.body));
        return product;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  Future<Product> patch({@required Product product}) async {
    try {
      var response = await this._patch(
          url: "products/${product.id}.json", data: productToMap(product));

      if (response.statusCode == HttpStatus.ok) {
        var product = Product.fromJson(json.decode(response.body));
        return product;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  Future<List<Product>> get({int id, Map<String, String> params}) async {
    var response = await this
        ._get(url: id != null ? "products/$id.json" : "products.json");

    print(response.body);

    List<Product> result = [];
    if (response.statusCode == HttpStatus.ok) {
      (json.decode(response.body) as Map<String, dynamic>).forEach(
          (key, value) => result.add(Product.fromJson(value, id: key)));
    }

    return result;
  }

  Future<Product> delete({@required Product product}) async {
    var response = await this._delete(url: "products/${product.id}.json");

    if (response.statusCode == HttpStatus.ok) {
      return product;
    } else
      return null;
  }
}
