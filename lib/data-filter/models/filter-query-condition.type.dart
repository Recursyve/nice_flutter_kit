class NiceFilterQueryConditionType {
  final String _value;

  const NiceFilterQueryConditionType._internal(this._value);

  String toString() => _value;

  static const And = const NiceFilterQueryConditionType._internal("and");
  static const Or = const NiceFilterQueryConditionType._internal("or");
}
