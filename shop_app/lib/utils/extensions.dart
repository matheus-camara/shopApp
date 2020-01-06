extension StringExtensions on String {
  bool get isNullOrEmpty => this?.isEmpty ?? true;
  double toDouble() => double.parse(this);
}