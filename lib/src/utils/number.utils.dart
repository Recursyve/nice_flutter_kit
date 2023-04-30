import "dart:math" as math;

class NumberUtils {
  const NumberUtils._();

  static num roundWithPrecision(num value, int precision) {
    final mod = math.pow(10, precision);
    final rounded = (value * mod).round().toDouble() / mod;

    if (rounded - rounded.toInt() == 0) {
      return rounded.toInt();
    }

    return rounded;
  }
}
