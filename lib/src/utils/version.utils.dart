import "dart:math";

class VersionUtils {
  const VersionUtils._();

  static int compare(String v1, String v2) {
    final v1Parts = v1.split(".").map((part) => int.tryParse(part)).toList(growable: false);
    final v2Parts = v2.split(".").map((part) => int.tryParse(part)).toList(growable: false);

    if (v1Parts.contains(null) || v2Parts.contains(null)) {
      throw const FormatException("Invalid version");
    }

    final minPartsLength = min(v1Parts.length, v2Parts.length);
    for (var i = 0; i < minPartsLength; i++) {
      if (v1Parts[i]! < v2Parts[i]!) {
        return -1;
      }

      if (v1Parts[i]! > v2Parts[i]!) {
        return 1;
      }
    }

    if (v1Parts.length < v2Parts.length) {
      return -1;
    }

    if (v1Parts.length > v2Parts.length) {
      return 1;
    }

    return 0;
  }

  static bool isLessThan(String current, String min) {
    return compare(current, min) == -1;
  }
}
