import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/domain/user.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/product.dart';

abstract class ServiceBase {
  final String _baseUrl;
  final String _token;

  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };

  ServiceBase(this._baseUrl, this._token);

  Future<http.Response> _post<T>({String url, @required T data}) =>
      http.post(_routeBuilder(url), body: json.encode(data), headers: headers);

  Future<http.Response> _patch<T>({String url, @required T data}) =>
      http.patch(_routeBuilder(url), body: json.encode(data));

  Future<http.Response> _delete({String url}) =>
      http.delete(_routeBuilder(url));

  Future<http.Response> _get({String url, Map<String, String> params}) =>
      http.get(_routeBuilder(url, params: params));

  String _routeBuilder(String url, {Map<String, String> params}) {
    var urlFinal = _baseUrl;

    if (url != null) urlFinal += "/$url";

    if (_token != null && params == null) urlFinal += "?auth=$_token";

    if (params != null && params.isNotEmpty) {
      if (_token != null) {
        params['auth'] = _token;
      }

      return Uri(path: "$_baseUrl/$url", queryParameters: params).toString();
    }

    return urlFinal;
  }
}

class OrderService extends ServiceBase {
  OrderService(String baseUrl, String token) : super(baseUrl, token);

  Map<String, dynamic> orderToMap(OrderItem order) => {
        "amount": order.amount,
        "date": DateTime.now().toUtc().toString(),
        "products": order.products
            .map((e) => {
                  "id": e.id,
                  "price": e.price,
                  "quantity": e.quantity,
                  "title": e.title
                })
            .toList()
      };

  Future<OrderItem> post({@required OrderItem orderItem}) async {
    try {
      var response =
          await this._post(url: "orders.json", data: orderToMap(orderItem));

      if (response.statusCode == HttpStatus.ok) {
        var order = OrderItem.fromJson(json.decode(response.body));
        return order;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  Future<OrderItem> delete({@required id}) async {
    try {
      var response = await _delete(url: "orders/$id.json");

      if (response.statusCode == HttpStatus.ok) {
        return OrderItem.fromJson({}, id: id);
      }

      return null;
    } catch (err) {
      return null;
    }
  }

  Future<List<OrderItem>> get({int id, Map<String, String> params}) async {
    var response =
        await this._get(url: id != null ? "orders/$id.json" : "orders.json");

    print(response.body);

    List<OrderItem> result = [];
    if (response.statusCode == HttpStatus.ok) {
      (json.decode(response.body) as Map<String, dynamic>).forEach(
          (key, value) => result.add(OrderItem.fromJson(value, id: key)));
    }

    return result;
  }
}

class ProductService extends ServiceBase {
  ProductService(String baseUrl, String token) : super(baseUrl, token);
  Map<String, dynamic> productToMap(Product product) => {
        "title": product.title,
        "price": product.price,
        "description": product.description,
        "imageUrl": product.imageUrl,
      };

  Future<Product> post({@required Product product, String token}) async {
    try {
      var response = await this._post(
          url: token == null ? "products.json" : "products.json?Auth=$token",
          data: productToMap(product));

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

  Future<Product> patch({@required Product product, String token}) async {
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

  Future<Product> patchMap(
      {@required String id, @required Map<String, dynamic> value}) async {
    try {
      var response = await this._patch(url: "products/$id.json", data: value);

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

  Future<List<Product>> get({Map<String, String> params}) async {
    var response = await this._get(url: "products.json");

    List<Product> result = [];
    if (response.statusCode == HttpStatus.ok) {
      (json.decode(response.body) as Map<String, dynamic>).forEach(
          (key, value) => result.add(Product.fromJson(value, id: key)));
    }

    return result;
  }

  Future<Product> fetch(String id) async {
    var response = await this._get(url: "products/$id.json");

    Product result;

    if (response.statusCode == HttpStatus.ok) {
      result = Product.fromJson(json.decode(response.body), id: id);
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

class AuthService extends ServiceBase {
  AuthService(String baseUrl) : super(baseUrl, null);

  Future<User> login(String email, String password) async {
    try {
      final response = await this._post(data: {
        "email": email,
        "password": password,
        "returnSecureToken": true
      });

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      return response.statusCode == HttpStatus.ok
          ? User.fromJson(responseData)
          : null;
    } catch (err) {
      return null;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      final response = await this._post(data: {
        "email": email,
        "password": password,
        "returnSecureToken": true
      });

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      return response.statusCode == HttpStatus.ok;
    } catch (err) {
      return false;
    }
  }
}
