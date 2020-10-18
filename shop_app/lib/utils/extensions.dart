extension StringExtensions on String {
  bool get isNullOrEmpty => this?.isEmpty ?? true;
  double toDouble() => double.parse(this);
}

extension ObjectExtensions on Object {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}
