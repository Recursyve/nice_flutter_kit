class FilterQueryConditionType {
  final String _value;

  const FilterQueryConditionType._internal(this._value);

  String toString() => _value;

  static const And = const FilterQueryConditionType._internal("and");
  static const Or = const FilterQueryConditionType._internal("or");
}
