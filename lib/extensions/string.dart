extension StringCasingExtension on String {
  String fromKebabCase() => replaceAll(RegExp('-'), ' ');

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  /// @todo This function only works correctly if the string's words are already
  /// separated by spaces. Ideally, this function should also change, for
  /// example, the string "fooBar" into "Foo Bar".
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((string) => string.toCapitalized())
      .join(' ');
}
