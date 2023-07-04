extension MapFilterExtension on Map<String, dynamic> {
  Map<String, dynamic> where(
    bool Function(MapEntry<String, dynamic> entry) test,
  ) {
    return Map.fromEntries(entries.where(test));
  }
}
