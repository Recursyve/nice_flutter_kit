class NiceCaseUtils {
  const NiceCaseUtils._();

  /// Converts a string to snake_case
  /// Digits are considered words
  static String toSnakeCase(String value) {
    final sb = StringBuffer();

    for (int i = 0; i < value.length; i++) {
      final lowerCased = value[i].toLowerCase();

      // Check if uppercase or digit
      if (value[i] != lowerCased || int.tryParse(value[i]) != null) {
        if (i != 0 && value[i - 1] != "_") sb.write("_");
        sb.write(lowerCased);
      } else if (value[i] == "-") {
        sb.write("_");
      } else {
        sb.write(value[i]);
      }
    }

    return sb.toString();
  }
}

extension StringCaseUtilsExt on String {
  String toSnakeCase() => NiceCaseUtils.toSnakeCase(this);
}
