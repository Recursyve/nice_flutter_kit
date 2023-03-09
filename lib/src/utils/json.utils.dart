class JsonUtils {
  const JsonUtils._();

  static T? parseIfNotNull<T, D>(dynamic data, T? Function(D) parser) {
    if (data == null) return null;
    return parser(data);
  }
}
