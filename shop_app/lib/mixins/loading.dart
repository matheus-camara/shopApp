import 'package:flutter/material.dart';

mixin StatefulLoadingWidget<T extends StatefulWidget> implements State<T> {
  var _isLoading = false;
  bool get isLoading => _isLoading;

  Future<T> withLoader<T>(Future<T> future) async {
    _toggleLoader();
    try {
      var resolved = await future;
      return resolved;
    } finally {
      _toggleLoader();
    }
  }

  void _toggleLoader() => setState(() => _isLoading = !_isLoading);
}
