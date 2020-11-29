import 'package:flutter/material.dart';

class User {
  String id;
  String token;
  DateTime expiration;

  User({@required this.id, @required this.token, @required this.expiration});

  User.fromJson(Map<String, dynamic> json, {String id})
      : this.id = id ?? json['localId'],
        token = json['idToken'],
        expiration =
            DateTime.now().add(Duration(seconds: int.parse(json['expiresIn'])));
}
